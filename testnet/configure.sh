#!/usr/bin/env bash

set -euo pipefail

# Always work relative to the location of configure.sh,
# regardless of where the script was invoked from.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

SETTINGS_FILE="$SCRIPT_DIR/settings.env"
CONFIG_DIR="$SCRIPT_DIR/config"
POSTMAN_DIR="$SCRIPT_DIR/postman"

if [[ ! -f "$SETTINGS_FILE" ]]; then
    echo "Error: settings.env not found: $SETTINGS_FILE" >&2
    exit 1
fi

if [[ ! -d "$CONFIG_DIR" ]]; then
    echo "Error: config directory not found: $CONFIG_DIR" >&2
    exit 1
fi


# Escape a string so that it can safely be used as the replacement
# portion of:
#
#     sed "s|pattern|replacement|g"
#
# &, \ and | have special meaning there.
escape_sed_replacement() {
    printf '%s' "$1" | sed 's/[&|\\]/\\&/g'
}


replace_in_file() {
    local file="$1"
    local key="$2"
    local value="$3"

    local escaped_value
    local tmp_file

    escaped_value="$(escape_sed_replacement "$value")"

    # Use a temporary file instead of `sed -i`.
    #
    # This avoids the GNU/Linux vs BSD/macOS difference in the
    # syntax of sed -i.
    tmp_file="$(mktemp "${file}.tmp.XXXXXX")"

    if sed "s|{{$key}}|$escaped_value|g" "$file" > "$tmp_file"; then
        # Using cat instead of mv preserves the original file's
        # ownership and permissions.
        cat "$tmp_file" > "$file"
        rm -f "$tmp_file"
    else
        rm -f "$tmp_file"
        echo "Error: failed to process $file" >&2
        exit 1
    fi
}


process_file() {
    local file="$1"
    local key
    local value
    local line
    local ngrok_dev_domain=""
    local base_url

    while IFS= read -r line || [[ -n "$line" ]]; do

        # Remove a possible CR from Windows CRLF files.
        line="${line%$'\r'}"

        # Ignore blank lines.
        [[ -z "$line" ]] && continue

        # Ignore comments.
        [[ "$line" =~ ^[[:space:]]*# ]] && continue

        # Ignore lines without '='.
        if [[ "$line" != *=* ]]; then
            echo "Warning: ignoring invalid settings.env line: $line" >&2
            continue
        fi

        key="${line%%=*}"
        value="${line#*=}"

        # Trim whitespace around the key.
        key="${key#"${key%%[![:space:]]*}"}"
        key="${key%"${key##*[![:space:]]}"}"

        # Keys are required to look like normal environment variable names.
        if [[ ! "$key" =~ ^[A-Za-z_][A-Za-z0-9_]*$ ]]; then
            echo "Warning: ignoring invalid key: $key" >&2
            continue
        fi

        replace_in_file "$file" "$key" "$value"

        if [[ "$key" == "NGROK_DEV_DOMAIN" ]]; then
            ngrok_dev_domain="$value"
        fi

    done < "$SETTINGS_FILE"

    # BASE_URL is a synthetic key derived from NGROK_DEV_DOMAIN.
    if [[ -n "$ngrok_dev_domain" ]]; then
        base_url="https://$ngrok_dev_domain"
    else
        base_url="http://host.docker.internal:9000"
    fi

    replace_in_file "$file" "BASE_URL" "$base_url"
}


echo "Applying settings from: $SETTINGS_FILE"

# Process YAML and JSON files recursively under config/.
while IFS= read -r -d '' file; do
    process_file "$file"
    echo "Processed: $file"
done < <(
    find "$CONFIG_DIR" -type f \
        \( -name '*.yaml' -o -name '*.yml' -o -name '*.json' \) \
        -print0
)


# Process Postman environment JSON files recursively under postman/.
if [[ -d "$POSTMAN_DIR" ]]; then
    while IFS= read -r -d '' file; do
        process_file "$file"
        echo "Processed: $file"
    done < <(
        find "$POSTMAN_DIR" -type f \
            -name '*postman_environment.json' \
            -print0
    )
else
    echo "Warning: postman directory not found: $POSTMAN_DIR" >&2
fi

echo "Configuration complete."