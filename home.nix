{ config, pkgs, ... }:
let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    niri = "niri";
    noctalia = "noctalia";
    hypr = "hypr";
    foot = "foot";
    nvim = "nvim";
  };
in
{
  home.username = "rez";
  home.homeDirectory = "/home/rez";
  home.stateVersion = "26.05";
  home.sessionVariables = {
    PATH = "$HOME/go/bin:$PATH";
    PS1 = "\[\e[38;5;98m\]\u@\[\e[38;5;79m\]\h\[\e[38;5;98m\]:\w\[\e[0m\] \[\e[38;5;79m\]\[\e[0m\] ";
  };
  programs.bash = {
    enable = true;
    shellAliases = {
      reze = "echo I love Reze!!!";
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#teal";
      trash = "sudo nix-collect-garbage -d";
    };
  };

  xdg.userDirs = {
    enable = true;
    pictures = "$HOME/images";
  };

  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = create_symlink "${dotfiles}/${subpath}";
    recursive = true;
  }) configs;

  home.packages = with pkgs; [
    neovim
    ripgrep
    nil
    nixd
    clang-tools
    go
    gopls
    rustc
    fd
    gnumake
    tree-sitter
    xclip
    lua-language-server
    nixpkgs-fmt
    pyright
    rust-analyzer
    nodejs
    gcc
    git
    foot
    thunar
    gh
    vesktop
    hyprshot
    fastfetch
    cargo
    stylua
    black
    isort
    prettierd
    intel-gpu-tools
    btop
    htop
  ];
}
