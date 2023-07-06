{ pkgs, name ? "minecraft", ram ? "16384M", ... } : pkgs.writeShellScriptBin "run.sh" ''

${pkgs.coreutils}/bin/mkdir -p /mnt/world_nether /mnt/world_the_end
${pkgs.coreutils}/bin/ln -s /mnt/world_nether /mnt/world_the_end /bin/${name}/

${pkgs.coreutils}/bin/mkdir -p /mnt/world/advancements /mnt/world/data /mnt/world/entities /mnt/world/playerdata /mnt/world/poi /mnt/world/region /mnt/world/stats
# ${pkgs.coreutils}/bin/touch /mnt/world/level.dat /mnt/world/uid.dat

${pkgs.coreutils}/bin/ln -s /mnt/world/advancements /mnt/world/data /mnt/world/entities /mnt/world/playerdata /mnt/world/poi /mnt/world/region /mnt/world/stats /mnt/world/level.dat /mnt/world/uid.dat /bin/${name}/world

${pkgs.jdk17}/bin/java -Djava.awt.headless=true -Xmx${ram} -Xms${ram} -jar /bin/${name}/server.jar

''