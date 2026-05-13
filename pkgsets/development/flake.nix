{
  description = "development tools";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

  outputs = { self, nixpkgs, ... }: let
    systems = [ "x86_64-linux" ];
    packages = pkgs: with pkgs; [
      git gh
      direnv nix-direnv
      gnumake cmake bear
      clang clang-tools
      gdb lldb
      unzip
      (python311.withPackages (p: [ p.requests ]))
      nodejs openjdk
    ];
  in {
    nixosModules.default = { pkgs, ... }: {
      users.users.maz.packages = packages pkgs;
    };

    devShells = nixpkgs.lib.genAttrs systems (system: {
      default = nixpkgs.legacyPackages.${system}.mkShell {
        packages = packages nixpkgs.legacyPackages.${system};
      };
    });
  };
}
