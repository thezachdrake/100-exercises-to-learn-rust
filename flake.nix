{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      #tools = import ./tools.nix { inherit pkgs; };
    in
    {
      devShells.x86_64-linux.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          cargo
          rustc
          rust-analyzer
          rustfmt
          clippy

        ];
        #++ (builtins.attrValues tools);
        shellHook = ''
          # Set up a local Cargo home with absolute paths
          export CARGO_HOME="$PWD/.cargo"
          export PATH="$CARGO_HOME/bin:$PATH"

          cargo install --locked workshop-runner
        '';
      };
    };
}
