# tmux Configuration

This repository contains my custom tmux configuration settings for improving the appearance of the status bar and pane borders.

## Configuration Details

The following settings are applied in my tmux configuration:

- **Status Bar**
  - Background color: Black
  - Foreground color: White

- **Pane Borders**
  - Inactive pane border color: White
  - Active pane border color: White

## Configuration Code

To apply this configuration, add the following lines to your `~/.tmux.conf` file:

```tmux
set -g status-bg black
set -g status-fg white
set -g pane-border-style fg=white
set -g pane-active-border-style fg=white
```

## Installation

1. Open your terminal.
2. Edit your tmux configuration file:
   ```sh
   nano ~/.tmux.conf
   ```
3. Copy and paste the above configuration.
4. Save the file and reload tmux:
   ```sh
   tmux source-file ~/.tmux.conf
   ```

## License

This configuration is open-source and free to use.

