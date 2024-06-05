rec {
  get-pm-field = { packageManager }: "${packageManager.packageName}@${packageManager.version}";

  devenv-sync-pm-module = { pkgs, packageManager }: {
    packages = [ pkgs.jq packageManager ];

    enterShell =
      let
        pm-field = get-pm-field { inherit packageManager; };
      in
      ''
        jq ".packageManager = \"${pm-field}\"" < package.json > package.json.tmp && mv package.json.tmp package.json
      '';
  };
}
