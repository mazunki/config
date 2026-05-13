{
  description = "terminal utilities";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

  outputs = { self, nixpkgs, ... }: let
    systems = [ "x86_64-linux" ];
    packages = pkgs: with pkgs; [
      eza ripgrep fd tldr
      zoxide bat tmux
      tree jq htop pstree delta
      texliveFull
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
