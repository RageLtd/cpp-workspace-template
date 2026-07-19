{
  config,
  pkgs,
}:
let
  toolchain = import ./toolchain.nix { inherit config pkgs; };
in
{
  devShell = pkgs.mkShell {
    packages = toolchain.packages;

    CC = "${toolchain.llvm.clang}/bin/clang";
    CXX = "${toolchain.llvm.clang}/bin/clang++";

    shellHook = ''
      echo "${config.project.description}"
      echo "Toolchain: ${config.toolchain.llvmPackageSet}; CMake + Ninja; Luau"
    '';
  };
}
