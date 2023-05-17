{ pkgs, ... }: {
  home.packages = with pkgs; [
    mtr
    unixtools.netstat
    nmap
    telnet
  ];
}
