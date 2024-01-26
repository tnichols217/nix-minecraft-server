{ pkgs, name ? "minecraft", ram ? "16384M", ... } : pkgs.writeShellScriptBin "run.sh" ''

_term() { 
  ${pkgs.coreutils}/bin/kill -TERM "$child" >/dev/null
}

trap _term SIGTERM
trap _term SIGINT

${pkgs.jdk17}/bin/java -Xmx${ram} -Xms${ram} -jar /bin/${name}/server.jar &

child=$! 
wait "$child"
''