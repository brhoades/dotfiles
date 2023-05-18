{ pkgs, ... }: {
  home.packages = with pkgs; [
    mtr
    unixtools.netstat
    nmap
    inetutils

    lsof
    netstat
    pcitools
    lshow

    htop

    ripgrep
    nnn
    bat
    curl
    httpie
    wget

    rsync
    rename # perl rename, not busybox

    perl

    git

    screen

    zip
    rar
    p7zip

    mosh
    psmisc
  ] ++ (if lib.strings.hasInfix "linux" pkgs.system then [
      iotop
      ngrok
    ] else []);
}