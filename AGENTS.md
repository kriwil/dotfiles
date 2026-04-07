# Repository Guidelines

## Project Structure & Module Organization

This repository is a `chezmoi` source tree for macOS dotfiles. Top-level files such as `dot_zshrc`, `dot_aerospace.toml`, and `dot_ideavimrc` map to real dotfiles in the target home directory. App-specific config lives under `dot_config/`, including `nvim/`, `nvim-pure/`, `ghostty/`, `sketchybar/`, `zellij/`, `borders/`, and `rift/`. Hammerspoon code lives in `dot_hammerspoon/`, with the bundled Lua module at `dot_hammerspoon/Spoons/PaperWM.spoon/` and its tests in `spec/`. Binary and font assets stay next to the config that consumes them, for example `dot_config/sketchybar/helpers/`.

## Build, Test, and Development Commands

Use `chezmoi diff` to preview what a change will write to the home directory, and `chezmoi apply` to apply it locally. Run `chezmoi status` before committing generated or accidental drift. For Lua formatting, use `stylua dot_config/nvim dot_config/nvim-pure`. For the bundled PaperWM spoon, run `cd dot_hammerspoon/Spoons/PaperWM.spoon && lua-language-server --check .` for static checks and `busted` for unit tests.

## Coding Style & Naming Conventions

Keep existing `chezmoi` naming intact: `dot_` becomes `.`, and `executable_` marks files that must stay executable. Lua uses 2-space indentation and a 120-column target, matching `stylua.toml`. In `PaperWM.spoon`, follow the existing conventions: globals in `PascalCase`, locals in `snake_case`, and functions in `camelCase`. Prefer small, focused config changes over broad rewrites across unrelated apps.

## Testing Guidelines

Test only the area you changed. Neovim and shell config changes should be validated with `chezmoi diff` plus a manual reload in the target app. PaperWM changes should include or update `spec/*_spec.lua` when behavior changes. Keep test files named after the module they cover, such as `tiling_spec.lua` or `floating_spec.lua`.

## Commit & Pull Request Guidelines

Recent commits use short, imperative subjects, often with a scope prefix like `jubilee: update sketchybar`. Follow that pattern and keep each commit focused on one tool or theme. Pull requests should summarize affected configs, list verification commands run, and include screenshots for visible UI changes such as SketchyBar, AeroSpace, or Hammerspoon behavior.

## Neovim

There are 2 configs for Neovim

- `nvim` is using LazyVim setup
- `nvim-pure` is bare neovim 0.12 setup

Whenever you're asked to add feature to `nvim-pure`, check how `nvim` and LazyVim are implement them. Try to use the same plugin as LazyVim unless asked differently.
Also refer to `nvim-pure/init.lua.bak`. That was my attempt to copy LazyVim functionality manually.

@RTK.md
