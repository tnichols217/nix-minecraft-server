nix build
ID=$(docker load < result \
| awk '{ print $NF}')
docker run --mount type=bind,source=$(pwd)/test,target=/mnt -p 25565:25565 -p 25575:25575 $ID