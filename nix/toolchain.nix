{ config, pkgs }:
let
  lib = pkgs.lib;
  llvmName = config.toolchain.llvmPackageSet;
  llvm =
    if builtins.hasAttr llvmName pkgs then
      builtins.getAttr llvmName pkgs
    else
      throw "workspace.nix selects missing nixpkgs attribute `${llvmName}`";
  packageAt =
    path:
    let
      attrs = lib.splitString "." path;
    in
    lib.attrByPath attrs (throw "workspace.nix selects missing package `${path}`") pkgs;
in
{
  inherit llvm;

  packages = [
    llvm.clang
    llvm.clang-tools
    llvm.lldb
    llvm.llvm
    pkgs.cmake
    pkgs.ninja
    pkgs.ccache
    pkgs.direnv
    pkgs.git
    pkgs.pkg-config
    pkgs.luau
    pkgs.luau-lsp
    pkgs.stylua
  ]
  ++ map packageAt config.toolchain.extraPackages
  ++ lib.optionals pkgs.stdenv.hostPlatform.isLinux [ pkgs.gdb ];
}
