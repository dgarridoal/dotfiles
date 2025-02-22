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
      system = "aarch64-darwin";  # Aquí se cambia el SO      pkgs = import nixpkgs { inherit system; };
    in {
      homeConfigurations = {
        "mrcajuka" =
          home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [
              ./nushell.nix  
              ./ghostty.nix  
              ./wezterm.nix  
              # ./zellij.nix   
              ./fish.nix
              ./starship.nix 
              ./nvim.nix     
              {
                # Datos personales
                home.username = "mrcajuk";
                home.homeDirectory = "/Users/mrcajuka/";
                home.stateVersion = "24.11";

                home.packages = with pkgs; [
                  # ─── Terminals y utilidades ───
                  zellij
                  zsh

                  # ─── Herramientas de desarrollo ───
                  #volta
                  #carapace
                  zoxide
                  atuin
                  #jq
                  bash
                  starship
                  fzf
                  neovim
                  #nodejs
                  lazygit
                  bun

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
