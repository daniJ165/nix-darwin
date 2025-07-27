{

  description = "My Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    mac-app-util.url = "github:hraban/mac-app-util";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, nix-homebrew, mac-app-util }:
  let
    configuration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = with pkgs;
        [ 
          neovim
	  kitty
	  git
	  #tailscale
          #pkgs.direnv
          #pkgs.sshs
          #pkgs.glow
          #pkgs.nushell
          #pkgs.carapace
        ];
      nix.settings.experimental-features = "nix-command flakes";
      programs.zsh.enable = true;  # default shell on catalina
      system.configurationRevision = self.rev or self.dirtyRev or null;
      system.stateVersion = 6;
      nixpkgs.hostPlatform = "aarch64-darwin";
      security.pam.services.sudo_local.touchIdAuth = true;


      system.primaryUser = "danielle";

      users.users.danielle.home = "/Users/danielle";

      #home-manager.backupFileExtension = "backup";

      system.defaults = {
        dock.autohide = true;
	dock.tilesize = 32;
	dock.wvous-bl-corner = 13;
	dock.mineffect = "scale";
	dock.slow-motion-allowed = true;

	#dock.persistent-apps.*.app = "zen-browser" "kitty";
	#dock.largesize = 128;
	#dock.persistent-apps 
        #dock.mru-spaces = false;
	#ActivityMonitor.IconType = 5;
        #finder.AppleShowAllExtensions = true;
        #finder.FXPreferredViewStyle = "clmv";
        #screensaver.askForPasswordDelay = 10;

        loginwindow.LoginwindowText = "rt*m";
        screencapture.location = "~/Pictures/screenshots";
	finder.AppleShowAllFiles = true;
	hitoolbox.AppleFnUsageType = "Do Nothing";
        controlcenter.AirDrop = true;

	controlcenter.BatteryShowPercentage = false;
	#how do i turn off the battery thing off completely to only use the smiley? turned off using settings for now.

	controlcenter.FocusModes = false;


        NSGlobalDomain.AppleICUForce24HourTime = true;
	NSGlobalDomain.AppleShowAllFiles = true;
	NSGlobalDomain.AppleInterfaceStyle = "Dark";
	NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;
	NSGlobalDomain.NSAutomaticDashSubstitutionEnabled = false;
	NSGlobalDomain.NSAutomaticInlinePredictionEnabled = false;
	NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled = false;
	NSGlobalDomain.NSAutomaticQuoteSubstitutionEnabled = false;
	NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;
	NSGlobalDomain.NSDocumentSaveNewDocumentsToCloud = false;
	NSGlobalDomain.NSTextShowsControlCharacters = true;
	NSGlobalDomain.NSWindowShouldDragOnGesture = true;
	NSGlobalDomain._HIHideMenuBar = true;
	NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;

      };

      system.keyboard = {
        enableKeyMapping = true;
        remapCapsLockToEscape = true; 
      };


      # Homebrew needs to be installed on its own!
      homebrew.enable = true;
      homebrew.onActivation.cleanup = "zap";
      homebrew.casks = [
	      "zen-browser"
	      "signal"
	      "discord"
	      "battery-buddy"
        ];
      homebrew.brews = [
	      #"jankyborders"

      ];
    };
  in
  {
    darwinConfigurations."macbook-air" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [ 
	configuration
	mac-app-util.darwinModules.default
          (
            { pkgs, config, inputs, ... }:
            {
              # To enable it for all users:
              home-manager.sharedModules = [
                mac-app-util.homeManagerModules.default
              ];
            }
          )
	nix-homebrew.darwinModules.nix-homebrew
	{
	  nix-homebrew = {
	    enable = true;
	    # Apple Silicon Only
	    #enableRosetta = true;
	    # User owning the Homebrew prefix
	    user = "danielle";
	  };
	}
        home-manager.darwinModules.home-manager 
	{
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.danielle = import ./home.nix;
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."macbook-air".pkgs;
  };
}
