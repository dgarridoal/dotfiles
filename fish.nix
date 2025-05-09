{ lib, ... }:
{
  home.activation.copyFish = lib.hm.dag.entryAfter ["writeBoundary"] ''
    echo "Copiando configuración de Fish..."
    rm -rf "$HOME/.config/fish"

    # Crear directorio .config si no existe
    mkdir -p "$HOME/.config"

    # Copiar toda la carpeta fish
    cp -r ${toString ./fish} "$HOME/.config/fish"
    
    # Asegurar permisos correctos
    chmod -R u+w "$HOME/.config/fish"
  '';

  programs.fish.enable = true;
}
