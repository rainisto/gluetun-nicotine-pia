#!/bin/bash
apt update && apt install -y wget
# Get forwarded port and public VPN IP
PIA_PORT=$(cat /gluetun/forwarded_port)
VPN_IP=$(wget -qO- ipaddress.ai/ip | tr -d '[:space:]')

# Validate IP format
if [[ ! $VPN_IP =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "ERROR: Invalid IP detected ($VPN_IP)" >&2
  exit 1
fi

# Nicotine+ config file location
CONFIG_FILE="/data/.config/nicotine/config"

# Backup original config
cp "$CONFIG_FILE" "${CONFIG_FILE}.bak"

# Update port range in config file using sed
sed -i "s/^portrange = (.*, .*)/portrange = (${PIA_PORT}, ${PIA_PORT})/" "$CONFIG_FILE"
sed -i "s/^upnp = .*/upnp = False/" "$CONFIG_FILE"

# Verify the change was made
if grep -q "^portrange = (${PIA_PORT}, ${PIA_PORT})" "$CONFIG_FILE"; then
  echo "Successfully updated Nicotine+ config:"
  grep "^portrange = " "$CONFIG_FILE"
else
  echo "Failed to update config file. Restoring backup..."
  mv "${CONFIG_FILE}.bak" "$CONFIG_FILE"
  exit 1
fi

echo "Restarting Nicotine+ to apply the new port settings"
pkill -SIGUSR1 nicotine
echo "Testing the port..."
wget https://www.slsknet.org/porttest.php?port=${PIA_PORT} -O - | grep ${PIA_PORT}
