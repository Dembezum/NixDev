{ lib, ... }:

{
  imports = [ ];

  boot = {
    initrd.availableKernelModules =
      [ "ata_piix" "uhci_hcd" "sr_mod" "xen_blkfront" ];
    initrd.kernelModules = [ ];
    kernelModules = [ ];
    extraModulePackages = [ ];

  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
