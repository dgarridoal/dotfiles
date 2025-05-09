
{ lib, ... }:
{
  home.activation.copyLazygit = lib.hm.dag.entryAfter ["writeBoundary"] ''
    echo "Copying fish configuration..."
    rm -rf "$HOME/.config/fish"

    # Verificar si el directorio .config existe, si no lo crea
    if [ ! -d "$HOME/.config" ]; then
      mkdir -p "$HOME/.config"
    fi

    cp -r ${toString ./fish} "$HOME/.config/fish"
    chmod -R u+w "$HOME/.config/fish"
  '';
}
