#!/usr/bin/env bash
set -euo pipefail

# Generate Ed25519 private key in DER format
openssl genpkey -algorithm Ed25519 -outform DER -out ed25519.der

# Extract:
# - last 32 bytes = private key seed
# - public key from openssl pkey -pubout

PRIVATE_B64=$(
    tail -c 32 ed25519.der | base64 | tr -d '\n'
)

PUBLIC_B64=$(
    openssl pkey -in ed25519.der -pubout -outform DER \
    | tail -c 32 \
    | base64 | tr -d '\n'
)

echo "=== Ed25519 Key Pair ==="
echo "signingPrivateKey: $PRIVATE_B64"
echo "signingPublicKey:  $PUBLIC_B64"

rm ed25519.der