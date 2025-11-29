{ pkgs, name ? "minecraft", ram ? "16384M", ... } : let
  root = "/mnt/${name}";
in pkgs.writeShellScriptBin "run.sh" ''

_term() { 
  ${pkgs.coreutils}/bin/kill -TERM "$child" >/dev/null
}

trap _term SIGTERM
trap _term SIGINT

${pkgs.coreutils}/bin/mkdir -p ${root}/world_nether ${root}/world_the_end
${pkgs.coreutils}/bin/ln -s ${root}/world_nether ${root}/world_the_end /bin/${name}/

${pkgs.coreutils}/bin/mkdir -p ${root}/world/advancements ${root}/world/data ${root}/world/entities ${root}/world/playerdata ${root}/world/poi ${root}/world/region ${root}/world/stats
# ${pkgs.coreutils}/bin/touch ${root}/world/level.dat ${root}/world/uid.dat

${pkgs.coreutils}/bin/ln -s ${root}/world/advancements ${root}/world/data ${root}/world/entities ${root}/world/playerdata ${root}/world/poi ${root}/world/region ${root}/world/stats ${root}/world/level.dat ${root}/world/uid.dat /bin/${name}/world

${pkgs.jdk25}/bin/java -Djava.awt.headless=true -Xmx${ram} -Xms${ram} -DIReallyKnowWhatIAmDoingISwear -jar /bin/${name}/server.jar &

child=$! 
wait "$child"

''