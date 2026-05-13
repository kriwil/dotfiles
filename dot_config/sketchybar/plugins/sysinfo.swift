// Sampling logic extracted from ~/Workspace/LittleSysinfo so the sketchybar
// menu-bar plugins use the exact same calculations as the LittleSysinfo app:
//   CPU   — host_processor_info tick deltas, active / (active + idle)
//   mem   — host_statistics64: (active + wired + compressed) * pageSize / total
//   disk  — volumeTotalCapacityKey - volumeAvailableCapacityForImportantUsageKey
//   temp  — private IOHIDEventSystemClient SPI, averaging pACC/eACC sensors

import Darwin
import Foundation
import IOKit

// MARK: - Formatting

func formatPercent(_ fraction: Double) -> String {
    let clamped = max(0.0, min(1.0, fraction))
    return "\(Int((clamped * 100).rounded()))%"
}

private let unitNumberFormatter: NumberFormatter = {
    let f = NumberFormatter()
    f.locale = Locale(identifier: "en_US_POSIX")
    f.numberStyle = .decimal
    f.usesGroupingSeparator = false
    f.minimumFractionDigits = 0
    f.maximumFractionDigits = 1
    f.roundingMode = .halfUp
    return f
}()

private struct ByteUnit { let suffix: String; let scale: Double }
private let binaryUnits: [ByteUnit] = [
    ByteUnit(suffix: "B", scale: 1),
    ByteUnit(suffix: "KB", scale: 1024),
    ByteUnit(suffix: "MB", scale: 1024 * 1024),
    ByteUnit(suffix: "GB", scale: 1024 * 1024 * 1024),
    ByteUnit(suffix: "TB", scale: 1024 * 1024 * 1024 * 1024),
]

func formatBytes(_ bytes: UInt64) -> String {
    let v = max(0, Double(bytes))
    var chosen = binaryUnits[0]
    for u in binaryUnits where v >= u.scale { chosen = u }
    let scaled = v / chosen.scale
    let digits = chosen.suffix == "B" ? 0 : 1
    unitNumberFormatter.maximumFractionDigits = digits
    let s = unitNumberFormatter.string(from: NSNumber(value: scaled)) ?? "\(scaled)"
    return "\(s) \(chosen.suffix)"
}

// MARK: - CPU

struct CPUReading { let usage: Double }

final class CPUSampler {
    private var previousTicks: [(UInt32, UInt32, UInt32, UInt32)] = []

    func sample() -> CPUReading {
        var cpuCount: natural_t = 0
        var cpuInfo: processor_info_array_t?
        var infoCount: mach_msg_type_number_t = 0
        let result = host_processor_info(mach_host_self(),
                                         PROCESSOR_CPU_LOAD_INFO,
                                         &cpuCount, &cpuInfo, &infoCount)
        guard result == KERN_SUCCESS, let cpuInfo else { return CPUReading(usage: 0) }
        defer {
            let size = vm_size_t(MemoryLayout<integer_t>.stride) * vm_size_t(infoCount)
            let address = vm_address_t(UInt(bitPattern: cpuInfo))
            vm_deallocate(mach_task_self_, address, size)
        }

        var current: [(UInt32, UInt32, UInt32, UInt32)] = []
        current.reserveCapacity(Int(cpuCount))
        let states = Int(CPU_STATE_MAX)
        for i in 0..<Int(cpuCount) {
            let base = i * states
            let user = UInt32(bitPattern: cpuInfo[base + Int(CPU_STATE_USER)])
            let system = UInt32(bitPattern: cpuInfo[base + Int(CPU_STATE_SYSTEM)])
            let idle = UInt32(bitPattern: cpuInfo[base + Int(CPU_STATE_IDLE)])
            let nice = UInt32(bitPattern: cpuInfo[base + Int(CPU_STATE_NICE)])
            current.append((user, system, idle, nice))
        }
        defer { previousTicks = current }

        guard previousTicks.count == current.count else { return CPUReading(usage: 0) }

        var totalActive: UInt64 = 0
        var totalAll: UInt64 = 0
        for (curr, prev) in zip(current, previousTicks) {
            let dUser = curr.0 &- prev.0
            let dSystem = curr.1 &- prev.1
            let dIdle = curr.2 &- prev.2
            let dNice = curr.3 &- prev.3
            let coreActive = UInt64(dUser) + UInt64(dSystem) + UInt64(dNice)
            totalActive += coreActive
            totalAll += coreActive + UInt64(dIdle)
        }
        guard totalAll > 0 else { return CPUReading(usage: 0) }
        return CPUReading(usage: Double(totalActive) / Double(totalAll))
    }
}

// MARK: - Memory

struct MemoryReading { let used: UInt64; let total: UInt64 }

final class MemorySampler {
    private let total: UInt64 = ProcessInfo.processInfo.physicalMemory
    private let pageSize: UInt64 = UInt64(vm_kernel_page_size)

    func sample() -> MemoryReading {
        var stats = vm_statistics64()
        var count = mach_msg_type_number_t(MemoryLayout<vm_statistics64_data_t>.stride / MemoryLayout<integer_t>.stride)
        let result = withUnsafeMutablePointer(to: &stats) { ptr -> kern_return_t in
            ptr.withMemoryRebound(to: integer_t.self, capacity: Int(count)) { rebound in
                host_statistics64(mach_host_self(), HOST_VM_INFO64, rebound, &count)
            }
        }
        guard result == KERN_SUCCESS else { return MemoryReading(used: 0, total: total) }
        let active = UInt64(stats.active_count)
        let wired = UInt64(stats.wire_count)
        let compressed = UInt64(stats.compressor_page_count)
        let used = (active + wired + compressed) * pageSize
        return MemoryReading(used: used, total: total)
    }
}

// MARK: - Disk

struct DiskReading { let used: UInt64; let total: UInt64 }

final class DiskSampler {
    private let url = URL(fileURLWithPath: "/")
    private static let keys: Set<URLResourceKey> = [
        .volumeTotalCapacityKey,
        .volumeAvailableCapacityForImportantUsageKey
    ]

    func sample() -> DiskReading {
        guard let values = try? url.resourceValues(forKeys: DiskSampler.keys),
              let total = values.volumeTotalCapacity,
              let available = values.volumeAvailableCapacityForImportantUsage
        else { return DiskReading(used: 0, total: 0) }
        let totalBytes = UInt64(total)
        let availableBytes = available >= 0 ? UInt64(available) : 0
        let used = totalBytes >= availableBytes ? totalBytes - availableBytes : 0
        return DiskReading(used: used, total: totalBytes)
    }
}

// MARK: - Temperature (private IOHID SPI)

@_silgen_name("IOHIDEventSystemClientCreate")
private func IOHIDEventSystemClientCreate(_ allocator: CFAllocator?) -> Unmanaged<AnyObject>?
@_silgen_name("IOHIDEventSystemClientSetMatching")
private func IOHIDEventSystemClientSetMatching(_ client: AnyObject, _ matching: CFDictionary) -> Int32
@_silgen_name("IOHIDEventSystemClientCopyServices")
private func IOHIDEventSystemClientCopyServices(_ client: AnyObject) -> Unmanaged<CFArray>?
@_silgen_name("IOHIDServiceClientCopyProperty")
private func IOHIDServiceClientCopyProperty(_ service: AnyObject, _ key: CFString) -> Unmanaged<CFTypeRef>?
@_silgen_name("IOHIDServiceClientCopyEvent")
private func IOHIDServiceClientCopyEvent(_ service: AnyObject, _ type: Int64,
                                         _ options: Int32, _ timestamp: Int64) -> Unmanaged<AnyObject>?
@_silgen_name("IOHIDEventGetFloatValue")
private func IOHIDEventGetFloatValue(_ event: AnyObject, _ field: Int32) -> Double

private let kIOHIDEventTypeTemperature: Int64 = 15
private let kHIDPage_AppleVendor: Int32 = 0xff00
private let kHIDUsage_AppleVendor_TemperatureSensor: Int32 = 0x0005
private var temperatureField: Int32 { Int32(kIOHIDEventTypeTemperature << 16) }

struct TemperatureReading { let celsius: Double? }

final class TemperatureSampler {
    private let client: AnyObject?
    private let cpuServices: [AnyObject]

    init() {
        guard let unmanaged = IOHIDEventSystemClientCreate(kCFAllocatorDefault) else {
            self.client = nil; self.cpuServices = []; return
        }
        let client = unmanaged.takeRetainedValue()
        self.client = client
        let matching: [String: Any] = [
            "PrimaryUsagePage": kHIDPage_AppleVendor,
            "PrimaryUsage": kHIDUsage_AppleVendor_TemperatureSensor,
        ]
        _ = IOHIDEventSystemClientSetMatching(client, matching as CFDictionary)
        let services: [AnyObject]
        if let arr = IOHIDEventSystemClientCopyServices(client)?.takeRetainedValue() as? [AnyObject] {
            services = arr
        } else { services = [] }
        let prefixes = ["pACC", "eACC"]
        let cpu = services.filter { service in
            guard let prop = IOHIDServiceClientCopyProperty(service, "Product" as CFString)?.takeRetainedValue(),
                  let name = prop as? String
            else { return false }
            return prefixes.contains { name.hasPrefix($0) }
        }
        self.cpuServices = cpu.isEmpty ? services : cpu
    }

    func sample() -> TemperatureReading {
        guard !cpuServices.isEmpty else { return TemperatureReading(celsius: nil) }
        var sum = 0.0
        var n = 0
        for service in cpuServices {
            guard let event = IOHIDServiceClientCopyEvent(service, kIOHIDEventTypeTemperature, 0, 0)?
                    .takeRetainedValue() else { continue }
            let v = IOHIDEventGetFloatValue(event, temperatureField)
            guard v.isFinite, v > 0, v < 200 else { continue }
            sum += v; n += 1
        }
        guard n > 0 else { return TemperatureReading(celsius: nil) }
        return TemperatureReading(celsius: sum / Double(n))
    }
}

// MARK: - CLI

let args = CommandLine.arguments
guard args.count >= 2 else {
    FileHandle.standardError.write(Data("usage: sysinfo <cpu|mem|disk|temp>\n".utf8))
    exit(2)
}

switch args[1] {
case "cpu":
    let s = CPUSampler()
    _ = s.sample()
    Thread.sleep(forTimeInterval: 0.5)
    print(formatPercent(s.sample().usage))
case "mem":
    let r = MemorySampler().sample()
    guard r.total > 0 else { exit(1) }
    print(formatPercent(Double(r.used) / Double(r.total)))
case "disk":
    let r = DiskSampler().sample()
    guard r.total > 0 else { exit(1) }
    print(formatPercent(Double(r.used) / Double(r.total)))
case "temp":
    guard let c = TemperatureSampler().sample().celsius else { exit(1) }
    print("\(Int(c.rounded()))°C")
default:
    FileHandle.standardError.write(Data("unknown metric: \(args[1])\n".utf8))
    exit(2)
}
