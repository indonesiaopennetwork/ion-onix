# Manual ONIX Configuration

Use these changes when configuring the local testnet without running `configure-testnet.sh` or `configure-testnet.bat`. Edit the existing files in place. In the attribute paths, `modules[name=...]` identifies an item in the `modules` list, and braces identify multiple attributes that require the same value.

`BASE_URL` means `https://<NGROK_DEV_DOMAIN>` when an ngrok domain is used. Without ngrok, use `http://host.docker.internal:9000`.

## `config/local-simple-bap.yaml`

| Attribute path | Value |
| --- | --- |
| `modules[name=bapTxnReceiver or bapTxnCaller].handler.plugins.registry.config.allowedNetworkIDs` | ION network ID; normally `ion.id/testnet` |
| `modules[name=bapTxnReceiver or bapTxnCaller].handler.plugins.keyManager.config.subscriberId` | BAP subscriber ID |
| `modules[name=bapTxnReceiver or bapTxnCaller].handler.plugins.keyManager.config.keyId` | BAP key ID |
| `modules[name=bapTxnReceiver or bapTxnCaller].handler.plugins.keyManager.config.{signingPrivateKey,encrPrivateKey}` | BAP private key |
| `modules[name=bapTxnReceiver or bapTxnCaller].handler.plugins.keyManager.config.{signingPublicKey,encrPublicKey}` | BAP public key |

## `config/local-simple-bpp.yaml`

| Attribute path | Value |
| --- | --- |
| `modules[name=bppTxnReceiver or bppTxnCaller].handler.plugins.registry.config.allowedNetworkIDs` | ION network ID; normally `ion.id/testnet` |
| `modules[name=bppTxnReceiver or bppTxnCaller or catalogPublish].handler.plugins.keyManager.config.subscriberId` | BPP subscriber ID |
| `modules[name=bppTxnReceiver or bppTxnCaller or catalogPublish].handler.plugins.keyManager.config.keyId` | BPP key ID |
| `modules[name=bppTxnReceiver or bppTxnCaller or catalogPublish].handler.plugins.keyManager.config.{signingPrivateKey,encrPrivateKey}` | BPP private key |
| `modules[name=bppTxnReceiver or bppTxnCaller or catalogPublish].handler.plugins.keyManager.config.{signingPublicKey,encrPublicKey}` | BPP public key |
| `modules[name=catalogPublish].handler.plugins.catalogPublisher.config.catalogBaseURL` | `BASE_URL` followed by `/beckn`, for example `https://example.ngrok-free.app/beckn` |

## `config/ngrok.yml`

| Attribute path | Value |
| --- | --- |
| `agent.authtoken` | ngrok authentication token |
| `tunnels.beckn.domain` | ngrok development domain without `https://` |

## `postman/IONStarterKitEnv.postman_environment.json`

| Attribute path | Value |
| --- | --- |
| `values[key=bap_id].value` | BAP subscriber ID |
| `values[key=base_url].value` | `BASE_URL` |
| `values[key=bpp_id].value` | BPP subscriber ID |
| `values[key=networkId].value` | ION network ID; normally `ion.id/testnet` |
