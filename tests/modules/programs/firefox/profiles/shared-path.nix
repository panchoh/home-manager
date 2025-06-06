modulePath:
{ config, lib, ... }:

let
  firefoxMockOverlay = import ../setup-firefox-mock-overlay.nix modulePath;
in
{
  imports = [ firefoxMockOverlay ];

  config = lib.mkIf config.test.enableBig (
    lib.setAttrByPath modulePath {
      enable = true;

      profiles = {
        main = {
          isDefault = true;
          id = 1;
          bookmarks = {
            force = true;
            settings = [
              {
                toolbar = true;
                bookmarks = [
                  {
                    name = "Home Manager";
                    url = "https://wiki.nixos.org/wiki/Home_Manager";
                  }
                ];
              }
            ];
          };
          containers = {
            "shopping" = {
              icon = "circle";
              color = "yellow";
            };
          };
          search = {
            force = true;
            default = "google";
            privateDefault = "ddg";
            engines = {
              bing.metaData.hidden = true;
              google.metaData.alias = "@g";
            };
          };
          settings = {
            "general.smoothScroll" = false;
            "browser.newtabpage.pinned" = [
              {
                title = "NixOS";
                url = "https://nixos.org";
              }
            ];
          };
        };
        "dev-edition-default" = {
          id = 2;
          path = "main";
        };
      };
    }
  );
}
