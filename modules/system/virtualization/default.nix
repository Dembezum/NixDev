{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    docker
    docker-compose
    qemu_kvm
    libvirt
  ];
}
