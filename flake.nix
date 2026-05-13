{
  description = "mazunki is a cute snowflake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    tui.url         = "path:./pkgsets/tui";         tui.inputs.nixpkgs.follows         = "nixpkgs";
    gui.url         = "path:./pkgsets/gui";         gui.inputs.nixpkgs.follows         = "nixpkgs";
    sway.url        = "path:./pkgsets/sway";        sway.inputs.nixpkgs.follows        = "nixpkgs";
    development.url = "path:./pkgsets/development"; development.inputs.nixpkgs.follows = "nixpkgs";
    vim.url         = "path:./pkgsets/vim";         vim.inputs.nixpkgs.follows         = "nixpkgs";
    gaming.url      = "path:./pkgsets/gaming";      gaming.inputs.nixpkgs.follows      = "nixpkgs";
    server.url      = "path:./pkgsets/server";      server.inputs.nixpkgs.follows      = "nixpkgs";

    forcexdg.url = "github:OSPG/force_xdg/flake";
  };

  outputs = { self, nixpkgs, tui, gui, sway, development, vim, gaming, server, forcexdg, ... }: let
    systems = [ "x86_64-linux" ];

    profileFlakes = {
      tty     = [ tui development vim ];
      server  = [ tui server ];
      desktop = [ tui gui sway development vim ];
      gaming  = [ tui gui sway gaming ];
    };

    forSystems = f: nixpkgs.lib.genAttrs systems
      (system: f (forcexdg.lib.extend nixpkgs.legacyPackages.${system}));
  in {
    overlays = forcexdg.overlays;

    nixosModules = builtins.mapAttrs (_: flakes:
      { imports = map (f: f.nixosModules.default) (flakes ++ [ forcexdg ]); }
    ) profileFlakes;

    devShells = forSystems (pkgs:
      builtins.mapAttrs (_: flakes:
        pkgs.mkShell {
          inputsFrom = map (f: f.devShells.${pkgs.system}.default) flakes;
        }
      ) profileFlakes
    );

    apps = forSystems (pkgs: let
      update = pkgs.writeShellApplication {
        name = "update";
        runtimeInputs = [ pkgs.nix pkgs.git ];
        text = ''
          nix flake update
          git add flake.lock
          git diff --cached --quiet || git commit -m "flake: update inputs"
          git push
        '';
      };
    in {
      update = { type = "app"; program = "${update}/bin/update"; };
    });
  };
}
