{ userSettings, ... }:

{
  # -- IMPORTS --
  imports = [
    ../../modules/user/tmux
    ../../modules/user/zsh

  ];

  # -- USER SETTINGS --
  home = {
    inherit (userSettings) username;
    homeDirectory = "/home/" + userSettings.username;

  };
  programs.home-manager.enable = true;

  # Package configuration
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  # -- VARIABLES --
  home.sessionVariables = {
    EDITOR = userSettings.editor;
    TERM = userSettings.term;
  };

  # -- XDG CONFIGURATION --
  xdg.enable = true;
  xdg.userDirs = {
    extraConfig = {

    };
  };
  home.stateVersion = userSettings.homestate;
}
