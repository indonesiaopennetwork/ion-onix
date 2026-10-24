# Manual ONIX Configuration

Use these changes when configuring BPP ONIX without running `configure-bpp-onix.sh`.

First, copy `../common/sample-configs/local-simple-bpp-sample.yaml` to `config/local-simple-bpp.yaml`. Then replace the values below. In the attribute paths, `modules[name=...]` identifies an item in the `modules` list, and braces identify multiple attributes that require the same value.

## `config/local-simple-bpp.yaml`

| Attribute path | Value |
| --- | --- |
| `plugins.otelsetup.config.producer` | BPP subscriber ID |
| `modules[name=bppTxnReceiver or bppTxnCaller].handler.subscriberId` | BPP subscriber ID |
| `modules[name=bppTxnReceiver or bppTxnCaller].handler.plugins.registry.config.allowedNetworkIDs` | `ion.id/staging` for staging; `ion.id/prod` for production |
| `modules[name=bppTxnReceiver or bppTxnCaller].handler.plugins.keyManager.config.subscriberId` | BPP subscriber ID |
| `modules[name=bppTxnReceiver or bppTxnCaller].handler.plugins.keyManager.config.keyId` | BPP key ID |
| `modules[name=bppTxnReceiver or bppTxnCaller].handler.plugins.keyManager.config.{signingPrivateKey,encrPrivateKey}` | BPP private key |
| `modules[name=bppTxnReceiver or bppTxnCaller].handler.plugins.keyManager.config.{signingPublicKey,encrPublicKey}` | BPP public key |

## `config/otel-collector-bpp/config.yaml`

| Attribute path | Value |
| --- | --- |
| `exporters.otlp_http/collector-network.endpoint` | `https://netcol.staging.ion.id` for staging and production |

The production collector currently uses the staging endpoint because `https://netcol.ion.id` is not yet active.
