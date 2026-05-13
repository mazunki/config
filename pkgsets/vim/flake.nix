{
  description = "vim/neovim and LSPs";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

  outputs = { self, nixpkgs, ... }: let
    systems = [ "x86_64-linux" ];
    packages = pkgs: with pkgs; [
      neovim
      tree-sitter
      lua-language-server
      nil
      pyright
      stylua
      nodePackages.typescript-language-server
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
