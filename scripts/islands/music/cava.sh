CONF_FILE="$DYNAMIC_ISLAND_DIR/scripts/islands/music/cava.conf"

while true
do
  cava -p "$CONF_FILE" | sed -u 's/ //g; s/0/▁/g; s/1/▂/g; s/2/▃/g; s/3/▄/g; s/4/▅/g; s/5/▆/g; s/6/▇/g; s/7/█/g; s/8/█/g' | while read line; do
    dynamic-island-sketchybar --set $NAME label=$line
  done
  sleep 5
done
