# canaudua
_canaudua_ is a theme for fish prompt. _canaudua_ is `Cá nấu dưa [kaː˧˥ nəw˧˥ zɨə˧˧]` in Vietnamese, and is a name of a fish dish with pickling that I like so much. You should try this and I hope that you will like it, same with me :).

## Installation

### System Requirements

- [fish](https://github.com/fish-shell/fish-shell) >= `3.2.0`
- [fisher](https://github.com/jorgebucaran/fisher)

Install by following command:
```fish
fisher install dynamotn/fish-canaudua
```

## Features

- **Async prompt rendering** — prompt segments are computed in a background subprocess so the shell stays responsive.
- **Transient prompt** — collapses previous prompts to a minimal view after a command is executed, keeping the scrollback clean (native from Fish 4.2.0, but you can use it in older versions with this plugin).
- **Two-line layout** — optional dual-line prompt that places info items on line 1 (left + right-aligned) and the input cursor on line 2.
- **Optional frame/border** — decorative top/bottom frame around the prompt that can be toggled.
- **Powerline-style segments** — adjacent segments share smooth separators; colors transition automatically between same-colored and different-colored segments.

### Prompt items

| Item | Description |
|------|-------------|
| `vi_mode` | Shows current vi key-binding mode (normal / insert / replace / visual). Hidden when vi bindings are not active. |
| `host_context` | `user@hostname` with a distro/OS icon. Changes color when connected via SSH, running as root, or inside a container. Detects macOS, Linux distros, BSD, Android/Termux. |
| `distrobox` | Displays the Distrobox container name when running inside one. |
| `shlvl` | Indicates shell nesting depth. Tmux/Zellij-aware (adjusts the baseline level). |
| `pwd` | Current directory with `~` substitution. Intermediate path segments are truncated to 2 characters. |
| `git` | Branch, tag, or short commit SHA; active operations (rebase, merge, cherry-pick, revert, bisect, am) with step/total progress; counts of staged, dirty, untracked, conflicted, and stashed changes; ahead/behind remote. Background color reflects repo state (clean / staged / dirty). |
| `direnv` | Icon shown when a `.envrc` is loaded and allowed by direnv. |
| `ruby` `python` `go` `rust` `node` `bun` `java` `php` `zig` `dotnet` | Active runtime/language version, displayed when a relevant project file is detected. |
| `gcloud` | Active Google Cloud configuration. |
| `aws` | Active AWS profile/region. |
| `azure` | Active Azure subscription. |
| `docker_context` | Active Docker context. |
| `kube_context` | Active Kubernetes context and namespace. Shortens GKE, EKS, and DOKS cluster names automatically. |
| `terraform` / `opentofu` | Active Terraform / OpenTofu workspace. |
| `jobs` | Number of background jobs currently running. |
| `duration` | Elapsed time of the last command, shown only when it exceeds a configurable threshold (default 2 s). Supports configurable decimal precision. |
| `status` | Exit status of the last command. Shows signal names for pipeline failures (e.g. `PIPE\|TERM`). Background color reflects success or failure. |
| `time` | Current time (`Day HH:MM:SS AM/PM`). |

### Show-on-command

Cloud and infrastructure items (`kube_context`, `docker_context`, `gcloud`, `aws`, `terraform`, `opentofu`) appear **only while you are typing a relevant command**, keeping the prompt uncluttered the rest of the time.

### Customization

All items, colors, glyphs, per-item command triggers, and glob patterns are stored as Fish universal variables and can be changed without restarting the shell.
