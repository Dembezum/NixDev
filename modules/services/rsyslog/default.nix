{
  services.rsyslogd = {
    enable = true;
    extraConfig = ''
      # Load necessary modules
      module(load="imudp")  # for UDP syslog reception
      input(type="imudp" port="1514")

      module(load="imtcp")  # for TCP syslog reception
      input(type="imtcp" port="1514")

      # Send all logs to a remote server
      *.*  @@10.0.40.48:1514 

      timezone(id="UTC" offset="+01:00")

      :msg, startswith, "IPTABLES" -/var/log/iptables.log
      :msg, contains, "error" /var/log/error.log
      :msg, contains, "authentication failure" /var/log/authfailure.log

      # Log all authpriv messages (including sudo) to /var/log/sudo.log
      authpriv.*  /var/log/sudo.log

      # Log Cron messages to /var/log/cron.log
      cron.*  /var/log/cron.log

      # Log Daemon messages to /var/log/daemon.log
      daemon.*  /var/log/daemon.log

    '';
  };

  # Ensure the sudo log file exists and has correct permissions
  systemd.tmpfiles.rules = [
    "f /var/log/sudo.log 0640 root adm - -"
    "f /var/log/error.log 0640 root adm - -"
    "f /var/log/cron.log 0640 root adm - -"
    "f /var/log/iptables.log 0640 root adm - -"
    "f /var/log/authfailure.log 0640 root adm - -"

  ];

  # Open firewall ports for syslog
  networking.firewall.allowedTCPPorts = [ 1514 ];
  networking.firewall.allowedUDPPorts = [ 1514 ];

}
