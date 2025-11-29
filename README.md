# nix-mc-build

Just a simple Nix flake for packaging the [mc-build cli tool](https://github.com/mc-build/mcb).

## Flake Usage Example
```nix
{
  description = "My flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    mc-build.url = "github:b0xfox/nix-mc-build";
  };

  outputs =
    { self, nixpkgs, mc-build, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [ mc-build.overlays.default ];
      };
    in
    {
      nixosConfigurations = {
        <your hostname> = nixpkgs.lib.nixosSystem {
          inherit pkgs;
          inherit inputs;
          inherit system;
          modules = [ ./configuration.nix ];
        };
      };
    };
}

```

The overlay will allow you to add the mc-build package to either your enviroment.systemPackages or home.packages just like any other packages
```nix
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    mc-build
  ];
}
```

Alternatively, you can also add the exposed package directly
```nix
{ inputs, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    inputs.mc-build.packages.${system}.mc-build
  ];
}
```



This is not an official mc-build resource.
