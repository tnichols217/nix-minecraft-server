{
  config = {
    server_connect_timeout = 5000;
    enforce_secure_profile = false;
    remote_ping_cache = -1;
    forge_support = false;
    player_limit = -1;
    permissions = {
      default = [
        "bungeecord.command.server"
        "bungeecord.command.list"
      ];
      admin = [
        "bungeecord.command.alert"
        "bungeecord.command.end"
        "bungeecord.command.ip"
        "bungeecord.command.reload"
        "bungeecord.command.kick"
      ];
    };
    timeout = 30000;
    log_commands = false;
    network_compression_threshold = 256;
    online_mode = false;
    disabled_commands = [
      # "disabledcommandhere"
    ];
    servers = {
      # survival = {
      #   motd = "Survival";
      #   address = "survival:25565";
      #   restricted = false;
      # };
      creative = {
        motd = "Creative";
        address = "creative:25565";
        restricted = false;
      };
    };
    listeners = [
      {
        query_port = 25565;
        motd = "deez";
        tab_list = "GLOBAL_PING";
        query_enabled = false;
        proxy_protocol = false;
        forced_hosts = {
          # pvp.md-5.net = "pvp";
        };
        ping_passthrough = true;
        priorities = [
          # "survival"
          "creative"
        ];
        bind_local_address = true;
        host = "0.0.0.0:25565";
        max_players = 1;
        tab_size = 60;
        force_default_server = false;
      }
    ];
    ip_forward = true;
    remote_ping_timeout = 5000;
    prevent_proxy_connections = false;
    groups = {
      tev99 = [
        "admin"
      ];
    };
    connection_throttle = 4000;
    stats = "9a75ded2-2895-4211-b315-d8ed24d826ce";
    connection_throttle_limit = 3;
    log_pings = true;
  };
  slashserver = {
    servers = [
      # {
      #   server = "survival";
      #   commands = [
      #     "survival"
      #     "main"
      #   ];
      #   "permission" = "slashserver.server.survival";
      # }
      {
        server = "creative";
        commands = [
          "creative"
        ];
        "permission" = "slashserver.server.creative";
      }
    ];
  };
}