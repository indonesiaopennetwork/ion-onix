#!/usr/bin/env bash

set -euo pipefail

CONFIG_FILE="config/local-simple-bap.yaml"

echo "Enter the ONIX configuration details"
echo

read -rp "subscriber_id: " SUBSCRIBER_ID
read -rp "private_key: " PRIVATE_KEY
read -rp "public_key: " PUBLIC_KEY
read -rp "keyId: " KEY_ID

echo
echo "This script will modify ONIX configuration at:"
echo "  config/*.yml"
echo

read -rp "Do you want to proceed? (yes/no): " CONFIRM

CONFIRM_LOWER=$(echo "$CONFIRM" | tr '[:upper:]' '[:lower:]')

case "$CONFIRM_LOWER" in
  yes|y)
    ;;
  *)
    echo "Operation cancelled."
    exit 0
    ;;
esac

if [[ ! -f "$CONFIG_FILE" ]]; then
  echo "Error: Config file not found: $CONFIG_FILE"
  exit 1
fi

TIMESTAMP=$(date +"%Y%m%d-%H%M%S")
BACKUP_FILE="config/local-simple-bap.${TIMESTAMP}.bak"

cp "$CONFIG_FILE" "$BACKUP_FILE"

ruby <<EOF
require 'yaml'

config_file = "$CONFIG_FILE"

subscriber_id = "$SUBSCRIBER_ID"
private_key  = "$PRIVATE_KEY"
public_key   = "$PUBLIC_KEY"
key_id       = "$KEY_ID"

data = YAML.load_file(config_file)

modules = data["modules"] || []

modules.each do |mod|
  begin
    cfg = mod["handler"]["plugins"]["keyManager"]["config"]

    cfg["networkParticipant"] = subscriber_id
    cfg["keyId"] = key_id

    cfg["signingPrivateKey"] = private_key
    cfg["encrPrivateKey"] = private_key

    cfg["signingPublicKey"] = public_key
    cfg["encrPublicKey"] = public_key
  rescue
    next
  end
end

content = YAML.dump(data)

content += "\n" unless content.end_with?("\n")

File.write(config_file, content)
EOF

echo
echo "Current configuration has been backed up to:"
echo "  $BACKUP_FILE"
echo
echo "Configuration has been updated successfully in:"
echo "  $CONFIG_FILE"
