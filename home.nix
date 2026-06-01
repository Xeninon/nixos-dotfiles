{ config, pkgs, ...}: 
let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    hypr = "hypr";
    foot = "foot";
    nvim = "nvim";
  };
in
{
  home.username = "rez";
  home.homeDirectory = "/home/rez";
  home.stateVersion = "25.11";
  programs.bash = {
    enable = true;
    shellAliases = {
      reze = "echo I love Reze!!!";
    };
  };
  
  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = create_symlink "${dotfiles}/${subpath}";
    recursive = true;
  }) configs;

  home.packages = with pkgs; [
    neovim
    ripgrep
    nil
    nixpkgs-fmt
    nodejs
    gcc
    git
    foot
    rofi
    thunar
    swaybg
  ];
}
