_term() { 
  kill -TERM "$child" 2>/dev/null
}

trap _term SIGTERM
trap _term SIGINT

yes > /dev/null &

child=$!
echo hello
wait "$child"