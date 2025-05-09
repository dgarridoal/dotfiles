
{ lib, ... }:
{
  home.activation.copyNvim = lib.hm.dag.entryAfter ["writeBoundary"] ''
    echo "Copying wezterm configuration..."
    rm -rf "$HOME/.config/wezterm"

    # Verificar si el directorio .config existe, si no lo crea
    if [ ! -d "$HOME/.config" ]; then
      mkdir -p "$HOME/.config"
    fi

    cp -r ${toString ./wezterm} "$HOME/.config/wezterm"
    chmod -R u+w "$HOME/.config/wezterm"
  '';
}
