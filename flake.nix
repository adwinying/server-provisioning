{
  description = "adwinying/server-provisioning";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/master";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShell = with pkgs; mkShell {
        buildInputs = [
          ansible
        ];

        shellHook = ''
          echo "ansible: `${pkgs.ansible}/bin/ansible --version`"
        '';
      };
    });
}
