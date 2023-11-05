{ pkgs, ... }:
{
  home.file.".skhdrc".source = ./dotskhdrc;
  home.file.".config/skhd/skhdrc".source = ./dotskhdrc;
  home.file.".yabairc".source = ./dotyabairc;
  home.file.".config/yabai/yabairc".source = ./dotyabairc;

  home.file."Library/LaunchAgents/com.koekeishiya.skhd.plist" = ./launchagents/com.koekeishiya.skhd.plist;
  home.file."Library/LaunchAgents/com.koekeishiya.yabai.plist" = ./launchagents/com.koekeishiya.yabai.plist;
]
