{ pkgs, inputs, ... }:

{
  programs.firefox = {
    enable = true;

    profiles.default = {
      id = 0;
      isDefault = true;

      settings = {
        "browser.startup.page" = 3;
        "browser.toolbars.bookmarks.visibility" = "never";
        "extensions.autoDisableScopes" = 0;

        "browser.search.suggest.enabled" = false;
        "browser.urlbar.quicksuggest.enabled" = false;
        "browser.urlbar.suggest.searches" = false;
        "browser.urlbar.suggest.bookmark" = false;
        "browser.urlbar.suggest.history" = false;
        "browser.urlbar.suggest.topsites" = false;
      };

      extensions.packages =
        with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
          proton-pass
          proton-vpn
          ghostery
        ];
    };
  };
}
