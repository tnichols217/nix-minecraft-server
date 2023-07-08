{ pkgs, name ? "minecraft", ram ? "16384M", ... } : pkgs.writeShellScriptBin "run.sh" ''

${pkgs.jdk17}/bin/java -Xmx${ram} -Xms${ram} -jar /bin/${name}/server.jar

''