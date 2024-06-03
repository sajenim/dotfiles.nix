{ ... }:

{
  services.forgejo = {
    enable = true;
    stateDir = "/srv/services/forgejo";
    settings = {
      server = {
        DOMAIN = "git.sajenim.dev";
        ROOT_URL = "https://git.sajenim.dev";
        HTTP_PORT = 3131;
        LANDING_PAGE = "/jasmine";
      };
      service = {
        DISABLE_REGISTRATION = true;
      };
      log.LEVEL = "Info";
    };
  };
}
