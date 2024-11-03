{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nixvim-flake.url = "github:dembezum/nixvim";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, nixos-wsl, ... }@inputs:
    let
      # Function to load each host's configuration file
      mkHostConfig = hostName: {
        # Import the host configuration, expecting systemSettings and userSettings to be defined
        inherit (import ./hosts/${hostName}/configuration.nix)
          systemSettings userSettings;

        # Define the actual system configuration
        system = nixpkgs.lib.nixosSystem {
          inherit (systemSettings) system;
          modules = [
            ./hosts/${hostName}/configuration.nix
            nixos-wsl.nixosModules.default
            home-manager.nixosModules.home-manager
            inputs.home-manager.nixosModules.default
            inputs.disko.nixosModules.disko
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.${userSettings.username} =
                  let pkgs = nixpkgs.legacyPackages.${systemSettings.system};
                  in import ./hosts/${hostName}/home.nix {
                    inherit inputs pkgs;
                    systemSettings = systemSettings;
                    userSettings = userSettings;
                  };
              };
            }
          ];
          specialArgs = { inherit inputs; };
        };
      };

    in {
      nixosConfigurations = {
        ReuterVPN = mkHostConfig "ReuterVPN";
        zumClust-MAS = mkHostConfig "zumClust-MAS";
        zumClust-REV = mkHostConfig "zumClust-REV";
        zumClust-SLA1 = mkHostConfig "zumClust-SLA1";
        zumClust-SLA2 = mkHostConfig "zumClust-SLA2";
        # Add other hosts here similarly
      };
    };
}
