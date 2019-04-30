ADDR=$(ip addr | grep wlp2s0 -A 5 | grep -Po "inet ([0-9\.]+)" | grep -Po "[0-9.]+")
echo "　$ADDR　"
