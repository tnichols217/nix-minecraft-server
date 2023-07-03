{
  banned-ips = [];
  banned-players = [];
  bukkit = {
    settings = {
      allow-end = true;
      warn-on-overload = true;
      permissions-file = "permissions.yml";
      update-folder = "update";
      plugin-profiling = "false";
      connection-throttle = 4000;
      query-plugins = true;
      deprecated-verbose = "default";
      shutdown-message = "Server closed";
      minimum-api = "none";
      use-map-color-cache = true;
    };
    spawn-limits = {
      monsters = 70;
      animals = 10;
      water-animals = 5;
      water-ambient = 20;
      water-underground-creature = 5;
      axolotls = 5;
      ambient = 15;
    };
    chunk-gc = {
      period-in-ticks = 600;
    };
    ticks-per = {
      animal-spawns = 400;
      monster-spawns = 1;
      water-spawns = 1;
      water-ambient-spawns = 1;
      water-underground-creature-spawns = 1;
      axolotl-spawns = 1;
      ambient-spawns = 1;
      autosave = 6000;
    };
    aliases = "now-in-commands.yml";
  };
  commands = {
    command-block-overrides = [];
    ignore-vanilla-permissions = false;
    aliases = {
      icanhasbukkit = [
        "version $1-"
      ];
    };
  };
  eula = {
    eula = true;
  };
  help = {};
  ops = [];
  permissions = {};
  server = {
    "enable-jmx-monitoring" = false;
    "rcon.port" = 25575;
    "level-seed" = 420;
    "gamemode" = "survival";
    "enable-command-block" = false;
    "enable-query" = false;
    "generator-settings" = "{}";
    "enforce-secure-profile" = true;
    "level-name" = "world";
    "motd" = "Deez";
    "query.port" = 25565;
    "pvp" = true;
    "generate-structures" = true;
    "max-chained-neighbor-updates" = 1000000;
    "difficulty" = "hard";
    "network-compression-threshold" = 256;
    "max-tick-time" = 60000;
    "require-resource-pack" = false;
    "use-native-transport" = true;
    "max-players" = 20;
    "online-mode" = true;
    "enable-status" = true;
    "allow-flight" = false;
    "initial-disabled-packs" = "";
    "broadcast-rcon-to-ops" = true;
    "view-distance" = 10;
    "server-ip" = "";
    "resource-pack-prompt" = "";
    "allow-nether" = true;
    "server-port" = 25565;
    "enable-rcon" = false;
    "sync-chunk-writes" = true;
    "op-permission-level" = 4;
    "prevent-proxy-connections" = false;
    "hide-online-players" = false;
    "resource-pack" = "";
    "entity-broadcast-range-percentage" = 100;
    "simulation-distance" = 10;
    "rcon.password" = "deezuz";
    "player-idle-timeout" = 0;
    "debug" = false;
    "force-gamemode" = false;
    "rate-limit" = 0;
    "hardcore" = false;
    "white-list" = false;
    "broadcast-console-to-ops" = true;
    "spawn-npcs" = true;
    "spawn-animals" = true;
    "function-permission-level" = 2;
    "initial-enabled-packs" = "vanilla";
    "level-type" = "minecraft\\:normal";
    "text-filtering-config" = "";
    "spawn-monsters" = true;
    "enforce-whitelist" = false;
    "spawn-protection" = 16;
    "resource-pack-sha1" = "";
    "max-world-size" = 29999984;
  };
  spigot = {
    settings = {
      debug = false;
      sample-count = 12;
      bungeecord = false;
      player-shuffle = 0;
      user-cache-size = 1000;
      save-user-cache-on-stop-only = false;
      moved-wrongly-threshold = 0.0625;
      moved-too-quickly-multiplier = 10.0;
      timeout-time = 60;
      restart-on-crash = true;
      restart-script = "./start.sh";
      netty-threads = 4;
      attribute = {
        maxHealth = {
          max = 2048.0;
        };
        movementSpeed = {
          max = 2048.0;
        };
        attackDamage = {
          max = 2048.0;
        };
      };
      log-villager-deaths = true;
      log-named-deaths = true;
    };
    messages = {
      whitelist = "You are not whitelisted on this server!";
      unknown-command = "Unknown command. Type "/help" for help.";
      server-full = "The server is full!";
      outdated-client = "Outdated client! Please use {0}";
      outdated-server = "Outdated server! I'm still on {0}";
      restart = "Server is restarting";
    };
    commands = {
      replace-commands = [
        "setblock"
        "summon"
        "testforblock"
        "tellraw"
      ];
      spam-exclusions = [
        "/skill"
      ];
      silent-commandblock-console = false;
      log = true;
      tab-complete = 0;
      send-namespaced = true;
    };
    world-settings = {
      default = {
        below-zero-generation-in-existing-chunks = true;
        verbose = true;
        growth = {
          cactus-modifier = 100;
          cane-modifier = 100;
          melon-modifier = 100;
          mushroom-modifier = 100;
          pumpkin-modifier = 100;
          sapling-modifier = 100;
          beetroot-modifier = 100;
          carrot-modifier = 100;
          potato-modifier = 100;
          wheat-modifier = 100;
          netherwart-modifier = 100;
          vine-modifier = 100;
          cocoa-modifier = 100;
          bamboo-modifier = 100;
          sweetberry-modifier = 100;
          kelp-modifier = 100;
          twistingvines-modifier = 100;
          weepingvines-modifier = 100;
          cavevines-modifier = 100;
        };
        entity-activation-range = {
          animals = 32;
          monsters = 32;
          raiders = 48;
          misc = 16;
          tick-inactive-villagers = true;
          ignore-spectators = false;
        };
        entity-tracking-range = {
          players = 48;
          animals = 48;
          monsters = 48;
          misc = 32;
          display = 128;
          other = 64;
        };
        ticks-per = {
          hopper-transfer = 8;
          hopper-check = 1;
        };
        hopper-amount = 1;
        hopper-can-load-chunks = false;
        merge-radius = {
          exp = 3.0;
          item = 2.5;
        };
        mob-spawn-range = 6;
        dragon-death-sound-radius = 0;
        seed-village = 10387312;
        seed-desert = 14357617;
        seed-igloo = 14357618;
        seed-jungle = 14357619;
        seed-swamp = 14357620;
        seed-monument = 10387313;
        seed-shipwreck = 165745295;
        seed-ocean = 14357621;
        seed-outpost = 165745296;
        seed-endcity = 10387313;
        seed-slime = 987234911;
        seed-nether = 30084232;
        seed-mansion = 10387319;
        seed-fossil = 14357921;
        seed-portal = 34222645;
        hunger = {
          jump-walk-exhaustion = 0.05;
          jump-sprint-exhaustion = 0.2;
          combat-exhaustion = 0.1;
          regen-exhaustion = 6.0;
          swim-multiplier = 0.01;
          sprint-multiplier = 0.1;
          other-multiplier = 0.0;
        };
        max-tnt-per-tick = 100;
        max-tick-time = {
          tile = 50;
          entity = 50;
        };
        item-despawn-rate = 6000;
        view-distance = "default";
        simulation-distance = "default";
        thunder-chance = 100000;
        enable-zombie-pigmen-portal-spawns = true;
        arrow-despawn-rate = 1200;
        trident-despawn-rate = 1200;
        wither-spawn-sound-radius = 0;
        end-portal-sound-radius = 0;
        hanging-tick-frequency = 100;
        zombie-aggressive-towards-villager = true;
        nerf-spawner-mobs = false;
      };
    };
    advancements = {
      disable-saving = false;
      disabled = [
        "minecraft:story/disabled"
      ];
    };
    players = {
      disable-saving = false;
    };
    config-version = 12;
    stats = {
      disable-saving = false;
      forced-stats = "{}";
    };
  };
  usercache = [];
  whitelist = [];
}