#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "${SCRIPT_DIR}/.." && pwd)"

CONFIG_FILE="${SCRIPT_DIR}/config/local-simple-bap.yaml"
SAMPLE_CONFIG_FILE="${REPO_ROOT}/common/sample-configs/local-simple-bap-sample.yaml"
BACKUP_ROOT="${SCRIPT_DIR}/backup"

replace_placeholders() {
  local config_file=$1
  local temporary_file
  local line

  temporary_file=$(mktemp "${config_file}.XXXXXX")

  while IFS= read -r line || [[ -n "$line" ]]; do
    line=${line//\{\{subscriberId\}\}/$SUBSCRIBER_ID}
    line=${line//\{\{privateKey\}\}/$PRIVATE_KEY}
    line=${line//\{\{publicKey\}\}/$PUBLIC_KEY}
    line=${line//\{\{keyId\}\}/$KEY_ID}
    printf '%s\n' "$line"
  done < "$config_file" > "$temporary_file"

  mv "$temporary_file" "$config_file"
}

echo "Welcome to BAP/CN configuration!"
echo "Enter the BAP/CN configuration details. These will be available in the setup section of the ION Devlabs portal."

read -rp "Subscriber Id: " SUBSCRIBER_ID
read -rp "Private Key: " PRIVATE_KEY
read -rp "Public Key: " PUBLIC_KEY
read -rp "Key ID: " KEY_ID

backup_file=""

if [[ -f "$CONFIG_FILE" ]]; then
  echo
  echo "An existing BAP configuration file was found at:"
  echo "  $CONFIG_FILE"
  echo "If you proceed, it will be backed up and replaced with a newly configured file."
  read -rp "Do you want to update the existing configuration? (yes/no): " CONFIRM

  CONFIRM_LOWER=$(printf '%s' "$CONFIRM" | tr '[:upper:]' '[:lower:]')

  case "$CONFIRM_LOWER" in
    yes|y)
      backup_directory="${BACKUP_ROOT}/$(date +'%Y%m%d%H%M')"
      mkdir -p "$backup_directory"
      backup_file="${backup_directory}/local-simple-bap.yaml"
      cp "$CONFIG_FILE" "$backup_file"
      ;;
    *)
      echo "BAP/CN configuration stopped. The existing configuration was not modified."
      exit 0
      ;;
  esac
fi

if [[ ! -f "$SAMPLE_CONFIG_FILE" ]]; then
  echo "Error: Sample configuration file not found:"
  echo "  $SAMPLE_CONFIG_FILE"
  exit 1
fi

mkdir -p "$(dirname -- "$CONFIG_FILE")"
cp "$SAMPLE_CONFIG_FILE" "$CONFIG_FILE"
replace_placeholders "$CONFIG_FILE"

echo
echo "BAP/CN configuration has been completed."
echo "The following file has been modified:"
echo "  $CONFIG_FILE"

if [[ -n "$backup_file" ]]; then
  echo "The previous configuration was backed up to:"
  echo "  $backup_file"
fi
