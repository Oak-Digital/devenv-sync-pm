{
  description = "Simple flake for syncing the package manager defined in devenv to the `packageManager` field in `package.json` on `enterShell`.";

  inputs = { };

  outputs = { self }: {
    lib = import ./lib.nix;
  };
}
