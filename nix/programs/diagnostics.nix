{ pkgs, ... }: {
  home.packages = with pkgs; [
    mtr
    netstat
    telnet
  ];
}
