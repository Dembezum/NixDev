# SSH setup
{
  services.openssh = {
    enable = true;
    settings = {
      UseDns = true;
      PasswordAuthentication = true;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "yes";
    };
    ports = [ 22 ];
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 ];
  };
}
