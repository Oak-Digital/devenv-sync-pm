Simple flake for syncing the package manager defined in devenv to the `packageManager` field in `package.json` on `enterShell`.

## Usage with flakes

Add the flake to your inputs

```nix
{
    inputs = {
        # ...
        sync-pm.url = "github:Oak-Digital/devenv-sync-pm";
    };
}
```

Add the module (`devenv-sync-pm-module`) which takes `pkgs` and `packageManager` as it's inputs.

```nix

let
    pkgs = nixpkgs.legacyPackages.${system};
    packageManager = pkgs.nodePackages.pnpm;
in
{
default =
    devenv.lib.mkShell {
        inherit inputs pkgs;
        modules = [
            (sync-pm.lib.devenv-sync-pm-module {
                inherit pkgs packageManager;
            })
            # Your other modules...
        ];
    };
};
```

Now whenever you trigger the `enterShell` from devenv, the `packageManager` field will get updated to what is defined in nix.
