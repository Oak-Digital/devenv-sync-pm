{
  description = "Simple flake for syncing the package manager defined in devenv to the `packageManager` field in `package.json` on `enterShell`.";

  inputs = { };

  outputs = { self }: {
    lib = {
      devenv-sync-pm-module = { pkgs, packageManager }: {
        packages = [ pkgs.jq packageManager ];

        enterShell = ''
          jq ".packageManager = \"${packageManager.packageName}@$(${packageManager.packageName} -v)\"" < package.json > package.json.tmp && mv package.json.tmp package.json
        '';
      };
    };
  };
}
