{
  description = "System configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    pyprland.url = "github:hyprland-community/pyprland";
  };

  outputs = { self, nixpkgs, pyprland, ... }@inputs: {
    # Please replace my-nixos with your hostname
    nixosConfigurations.zduo = nixpkgs.lib.nixosSystem {
      specialArgs = inputs;
      system = "x86_64-linux";
      modules = [
        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
        ./configuration.nix
      ];
    };
  };
}
