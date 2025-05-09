{ lib, ... }:
{
  home.activation.copyNvim = lib.hm.dag.entryAfter ["writeBoundary"] ''
    echo "Copying zsh configuration..."
    rm -rf "$HOME/.zshrc"

    cp -r ${toString ./zsh} "$HOME/.zshrc"
    chmod -R u+w "$HOME/.zshrc"
  '';
}
