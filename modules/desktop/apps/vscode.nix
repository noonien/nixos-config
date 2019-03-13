
{ config, pkgs, ... }:
let
    vscode = pkgs.vscodium;
    vscode-utils = (pkgs.unstable.vscode-utils.override { vscode = vscode; });
    vscode-extensions = (pkgs.unstable.vscode-extensions.override { vscode-utils = vscode-utils; });
    extensions = (with vscode-extensions; [
        #ms-python.python
    ]) ++ vscode-utils.extensionsFromVscodeMarketplace [
    ];
in
{
  environment.systemPackages = with pkgs; [
      (vscode-with-extensions.override {
          vscode = vscode;
          vscodeExtensions = extensions;
      })
  ];
}
