{ config, lib, ... }:

# This isn't used.
with lib; {
  options = {
    brodes = {
      desktop = mkEnableOption "Whether this a graphical machine.";
      development = mkEnableOption "Whether this is a development machine.";
    };
  };
}
