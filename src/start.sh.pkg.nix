{ pkgs, name ? "minecraft", ram ? "16384M", ... } : pkgs.writeShellScriptBin "run.sh" ''

JAVA=$1

mkdir -p /mnt/world_nether /mnt/world_the_end
cp -s /mnt/world_nether /mnt/world_the_end /bin/${name}/

mkdir -p /mnt/world/advancements /mnt/world/data /mnt/world/entities /mnt/world/playerdata /mnt/world/poi /mnt/world/region /mnt/world/stats
touch /mnt/world/level.dat /mnt/world/uid.dat

cp -s /mnt/world/advancements /mnt/world/data /mnt/world/entities /mnt/world/playerdata /mnt/world/poi /mnt/world/region /mnt/world/stats /mnt/world/level.dat /mnt/world/uid.dat /bin/${name}/world

$JAVA -jar -Djava.awt.headless=true -Xmx${ram} -Xms${ram} -jar /bin/${name}/server.jar

''