{
  description = "Portable C++ and Luau workspace";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { nixpkgs, ... }:
    let
      config = import ./workspace.nix;
      forAllSystems = nixpkgs.lib.genAttrs config.nix.systems;
      pkgsFor = system: import nixpkgs { inherit system; };
      workspaceFor =
        system:
        import ./nix/workspace.nix {
          inherit config;
          pkgs = pkgsFor system;
        };
    in
    {
      devShells = forAllSystems (system: {
        default = (workspaceFor system).devShell;
      });

      formatter = forAllSystems (system: (pkgsFor system).nixfmt);
    };
}
