# Manual ONIX Configuration

Use these changes when configuring the Catalog Publisher without running `configure-catalog-publisher.sh`.

First, copy `../common/sample-configs/local-simple-catalog-publisher-sample.yaml` to `config/local-simple-catalog-publisher.yaml`. Then replace the values below. In the attribute paths, `modules[name=...]` identifies an item in the `modules` list, and braces identify multiple attributes that require the same value.

## `config/local-simple-catalog-publisher.yaml`

| Attribute path | Value |
| --- | --- |
| `modules[name=catalogPublish].subscriberId` | BPP subscriber ID |
| `modules[name=catalogPublish].handler.plugins.registry.config.allowedNetworkIDs` | `ion.id/staging` for staging; `ion.id/prod` for production |
| `modules[name=catalogPublish].handler.plugins.keyManager.config.subscriberId` | BPP subscriber ID |
| `modules[name=catalogPublish].handler.plugins.keyManager.config.keyId` | BPP key ID |
| `modules[name=catalogPublish].handler.plugins.keyManager.config.{signingPrivateKey,encrPrivateKey}` | BPP private key |
| `modules[name=catalogPublish].handler.plugins.keyManager.config.{signingPublicKey,encrPublicKey}` | BPP public key |
| `modules[name=catalogPublish].handler.plugins.catalogPublisher.config.catalogBaseURL` | Web-accessible base URL for the published catalog, for example `https://example.com/beckn` |
