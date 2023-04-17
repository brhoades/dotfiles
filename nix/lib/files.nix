{ pkgs, ... }: {
  # I can never find this with the internal name
  readNoNewline = nixpkgs.lib.fileContents;
  # consistency
  read = builtins.readFile;

}
