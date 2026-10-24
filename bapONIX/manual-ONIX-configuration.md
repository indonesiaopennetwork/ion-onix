# Manual ONIX Configuration

Use these changes when configuring BAP ONIX without running `configure-bap-onix.sh`.

First, copy `../common/sample-configs/local-simple-bap-sample.yaml` to `config/local-simple-bap.yaml`. Then replace the values below. In the attribute paths, `modules[name=...]` identifies an item in the `modules` list, and braces identify multiple attributes that require the same value.

## `config/local-simple-bap.yaml`

| Attribute path | Value |
| --- | --- |
| `plugins.otelsetup.config.producer` | BAP subscriber ID |
| `modules[name=bapTxnReceiver or bapTxnCaller].handler.subscriberId` | BAP subscriber ID |
| `modules[name=bapTxnReceiver or bapTxnCaller].handler.plugins.registry.config.allowedNetworkIDs` | `ion.id/staging` for staging; `ion.id/prod` for production |
| `modules[name=bapTxnReceiver or bapTxnCaller].handler.plugins.keyManager.config.subscriberId` | BAP subscriber ID |
| `modules[name=bapTxnReceiver or bapTxnCaller].handler.plugins.keyManager.config.keyId` | BAP key ID |
| `modules[name=bapTxnReceiver or bapTxnCaller].handler.plugins.keyManager.config.{signingPrivateKey,encrPrivateKey}` | BAP private key |
| `modules[name=bapTxnReceiver or bapTxnCaller].handler.plugins.keyManager.config.{signingPublicKey,encrPublicKey}` | BAP public key |

## `config/otel-collector-bap/config.yaml`

| Attribute path | Value |
| --- | --- |
| `exporters.otlp_http/collector-network.endpoint` | `https://netcol.staging.ion.id` for staging and production |

The production collector currently uses the staging endpoint because `https://netcol.ion.id` is not yet active.
