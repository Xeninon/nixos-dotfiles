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
  home.stateVersion = "26.05";
  programs.bash = {
    enable = true;
    shellAliases = {
      reze = "echo I love Reze!!!";
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#teal";
      trash = "sudo nix-collect-garbage -d";
    };
    initExtra = ''
      PS1='\[\e[38;5;57m\]\u@\[\e[38;5;79m\]\h\[\e[38;5;63m\]:\[\e[38;5;57m\]\w\\$\[\e[0m\] '
    '';
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
    rofi
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
    htop
  ];
}
