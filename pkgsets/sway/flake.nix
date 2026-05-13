{
  description = "sway wayland compositor";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

  outputs = { self, nixpkgs, ... }: let
    systems = [ "x86_64-linux" ];
    packages = pkgs: with pkgs; [
      waybar wofi mako
      grim slurp
      wl-clipboard clipman wl-mirror
      kitty
    ];
  in {
    nixosModules.default = { pkgs, ... }: {
      users.users.maz.packages = packages pkgs;
      programs.sway = { enable = true; wrapperFeatures.gtk = true; };
      services.xserver.xkb = { layout = "us"; variant = "altgr-intl"; };
      fonts.packages = with pkgs; [
        font-awesome
        noto-fonts noto-fonts-emoji noto-fonts-cjk-sans noto-fonts-extra
        fira-code fira-code-symbols fira-math
        libertinus inter ibm-plex
        nerd-fonts.symbols-only
        inconsolata jetbrains-mono source-code-pro
      ];
    };

    devShells = nixpkgs.lib.genAttrs systems (system: {
      default = nixpkgs.legacyPackages.${system}.mkShell {
        packages = packages nixpkgs.legacyPackages.${system};
      };
    });
  };
}
