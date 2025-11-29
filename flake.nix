{
  description = "Nix Flake for packaging mc-build";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      forEachSystem = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;

      mc-buildPackages =
        system:
        let
          pkgs = import nixpkgs { inherit system; };

          mc-build = pkgs.callPackage ./mc-build { };

          addedPackages = {
            inherit mc-build;
          };
        in
        addedPackages;
    in
    {
      packages = forEachSystem mc-buildPackages;

      overlays.default = final: prev: {
        inherit (self.packages.${prev.stdenv.hostPlatform.system}) mc-build;
      };
    };
}
