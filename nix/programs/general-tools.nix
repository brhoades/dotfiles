{ pkgs, ... }: {

  home.packages = with pkgs;
    [
      mtr
      unixtools.netstat
      nmap
      inetutils

      lsof

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
    ] ++ (if lib.strings.hasInfix "linux" pkgs.system then [
      iotop
      ngrok
      psmisc
    ] else
      [ ]);
}
