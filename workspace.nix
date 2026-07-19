{
  # This is the only file used to configure the development environment.
  # Direnv watches it and reloads the environment when it changes.
  project = {
    name = "cpp_workspace_template";
    description = "Portable C++ and Luau workspace for Zed";
  };

  nix = {
    # Add or remove host platforms here. Native Windows development is expected
    # to use WSL. Current nixpkgs no longer supports Intel macOS.
    systems = [
      "aarch64-darwin"
      "aarch64-linux"
      "x86_64-linux"
    ];
  };

  toolchain = {
    # This is the single LLVM version switch. It selects an attribute from the
    # pinned nixpkgs input, so clang, clangd, clang-format, clang-tidy, LLDB,
    # coverage tools, and symbol tools all move together.
    llvmPackageSet = "llvmPackages_21";

    # Add nixpkgs attribute paths such as "doxygen" or "valgrind" here. Dotted
    # paths are supported. Platform-specific packages should be added in
    # nix/toolchain.nix instead.
    extraPackages = [ ];
  };
}
