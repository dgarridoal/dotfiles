
{ lib, ... }:
{
  home.activation.copyStarship = lib.hm.dag.entryAfter ["writeBoundary"] ''
    echo "Copying starship configuration..."
    rm -rf "$HOME/.config/starship"

    # Verificar si el directorio .config existe, si no lo crea
    if [ ! -d "$HOME/.config" ]; then
      mkdir -p "$HOME/.config"
    fi

    cp -r ${toString ./starship} "$HOME/.config/starship"
    chmod -R u+w "$HOME/.config/starship"
  '';
}
