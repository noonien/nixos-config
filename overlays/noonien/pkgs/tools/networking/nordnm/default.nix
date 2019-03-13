{ lib, fetchFromGitHub, python3Packages }:

let inherit (python3Packages) python buildPythonApplication fetchPypi;
in buildPythonApplication rec {
  name = "nordnm-${version}";
  version = "0.7.1";

  src = fetchFromGitHub {
    owner = "Chadsr";
    repo = "NordVPN-NetworkManager";
    rev = "07f705e3fb8bbbff4836bf331558a7ad4bf3c0fd";
    sha256 = "0lf42ffmq8kr32cwnfyshxr8vv21zmgir58lrjvm0cv693v6ms8c";
  };

  pythonPath = with python3Packages; [ numpy requests urllib3 chardet ];

  # package doesn't have any tests, so don't run them
  doCheck = false;

  meta = with lib; {
    description = "A CLI tool for automating the importing, securing and usage of NordVPN OpenVPN servers through NetworkManager.";
    homepage = https://github.com/Chadsr/NordVPN-NetworkManager;
    license = licenses.gplv3;
    platforms = platforms.linux;
  };
}
