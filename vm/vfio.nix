{ config, pkgs, ... }:

{

  # Enable dconf (System Management Tool)
  programs.dconf.enable = true;
  programs.virt-manager.enable = true;

  # Add user to libvirtd group
  users.users.anas.extraGroups = [ "libvirtd" "kvm" "qemu" ];

  # Stuff To Make UEFI Do KVM / OVMF / Passthrogh
  boot.kernelParams = [ "intel_iommu=on" "iommu=pt" ];
  boot.kernelModules = [ "kvm-intel" "vfio" "vfio_iommu_type1" "vfio-pci" "vfio_virqfd" ];


  # Install necessary packages
  environment.systemPackages = with pkgs; [
    dconf # needed for saving settings in virt-manager
    libguestfs # needed to virt-sparsify qcow2 files
  ];

  # Manage the virtualisation services
  virtualisation = {
    libvirtd = {
      enable = true;
      onBoot = "ignore";
      onShutdown = "shutdown";
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };
    spiceUSBRedirection.enable = true;
  };
  services.spice-vdagentd.enable = true;
  systemd.services.libvirtd = {
    path = let
             env = pkgs.buildEnv {
               name = "qemu-hook-env";
               paths = with pkgs; [
                 bash
                 libvirt
                 kmod
                 systemd
                 ripgrep
                 sd
               ];
             };
           in
           [ env ];
    preStart =
    ''

      mkdir -p /var/lib/libvirt/hooks
      mkdir -p /var/lib/libvirt/hooks/qemu.d/win11/prepare/begin
      mkdir -p /var/lib/libvirt/hooks/qemu.d/win11/release/end
      
      ln -sf /etc/nixos/vm/qemu /var/lib/libvirt/hooks/qemu
      ln -sf /etc/nixos/vm/start.sh /var/lib/libvirt/hooks/qemu.d/win11/prepare/begin/start.sh
      ln -sf /etc/nixos/vm/start.sh /var/lib/libvirt/hooks/qemu.d/win11/release/end/stop.sh
      
      chmod +x /var/lib/libvirt/hooks/qemu
      chmod +x /var/lib/libvirt/hooks/qemu.d/win11/prepare/begin/start.sh
      chmod +x /var/lib/libvirt/hooks/qemu.d/win11/release/end/stop.sh
    '';
  };
}
