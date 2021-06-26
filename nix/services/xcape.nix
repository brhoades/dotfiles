{ ... }: {
  services.xcape = {
    enable = false;
    timeout = 500; # ms
    mapExpression = {
      # Control behaves as escape when pressed and released
      # within the timeout.
      Control_L = "Escape";
    };
  };
}
