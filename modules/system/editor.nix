{ config, pkgs, options, ... }:

{
	nixpkgs.config.packageOverrides = pkgs: {
		neovim = pkgs.neovim.override {
			viAlias = true;
			vimAlias = true;
			withNodeJs = true;
		};
	};

	environment.variables = {
		EDITOR = "nvim";
	};

	environment.systemPackages = with pkgs; [
		unstable.neovim
	];
}
