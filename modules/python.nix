{ config, pkgs, ... }:

let
  pythonPackages = (ps: with ps; [ requests autopep8 ]);
in
{
  environment.systemPackages = with pkgs; [
    (python.withPackages pythonPackages)
    (python3.withPackages pythonPackages)
  ];
}
