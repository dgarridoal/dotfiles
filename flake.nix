{
  description = "MrCajuka: Dotfiles unique";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "aarch64-darwin";  # Aquí se cambia el SO
      pkgs = import nixpkgs { inherit system; };
    in {
      homeConfigurations = {
        "mrcajuka" =
          home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [
              ./fish.nix
              ./ghostty.nix
              ./lazygit.nix
              ./nvim.nix
              ./starship.nix
              ./wezterm.nix
              ./zellij.nix
              ./zsh.nix
              {
                # Datos personales
                home.username = "mrcajuka";
                home.homeDirectory = "/Users/mrcajuka/";
                home.stateVersion = "24.11";

                home.packages = with pkgs; [
                  # ─── Terminals y utilidades ───
                  zellij
                  fish
                  zsh

                  # ─── Herramientas de desarrollo ───
                  zoxide
                  atuin
                  bash
                  starship
                  fzf
                  neovim
                  lazygit
                  bun
                  cargo
                  fnm

                  # ─── Compiladores y utilidades de sistema ───
                  gcc
                  fd
                  ripgrep
                  coreutils
                  bat
                  lazygit

                  # ─── Nerd Fonts ───
                  nerd-fonts.iosevka-term
                ];

              }
            ];
          };
      };
    };
}
