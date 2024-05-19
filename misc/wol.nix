{pkgs, ... }:
{
  # Makes The Adapter Accept Magic Packates 
  networking.interfaces.enp3s0.wakeonlan.enable = true;

  # Wake on Lan Service
  systemd.services.wakeonlan = {
    description = "WakeonLan Service";
    after = [ "network.target" ];
    serviceConfig = {
      Type = "simple";
      RemainAfterExit = "true";
      ExecStart = "${pkgs.ethtool}/sbin/ethtool -s enp3s0 wol g";
    };
    wantedBy = [ "default.target" ];
  };
}
