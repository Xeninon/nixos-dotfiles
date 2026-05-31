{
  config,
  pkgs,
  ...
}: {
  home.username = "rez";
  home.homeDirectory = "/home/rez";
  home.stateVersion = "25.11";
  programs.bash = {
    enable = true;
    shellAliases = {
      reze = "echo I love Reze!!!";
    };
  };
}
