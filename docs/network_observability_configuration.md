## Introduction

This document describes the Network Observability(NO) configuration to be done by network participants on ION to be compliant with ION requirements. 

Network Observability is a key component of ION. ION relies on network observability to provide many value added functionality for NPs including but not limited to:
  - Settlment assistance
  - Grievance management

In addition Network Observability also provides ION itself with visibility on Network Participant activity and health. The data collection foundation for network observability is architected around the **OpenTelemetry ecosystem (OTel)**.

## Network Observability data requirements

The section will be extended to add a link to a more detailed document on the requirements of data to be sent to the network observability server. This list summarizes that document. Network observability needs:

- Beckn Message sent and received by the NP on the ION network must be sent. The logs sent must have PII removed from them. 

### ION-ONIX and network observability

ION-ONIX comes with the base functionality required for network observability built in. ION-ONIX is based on Beckn ONIX and this [document](https://github.com/beckn/beckn-onix/blob/main/pkg/plugin/implementation/otelsetup/OBSERVABILITY.md) from the Beckn-ONIX repository gives a overview of the overall architecture. While the ONIX functionality is extensive, we use only the `Network Observer` part of the functionality for ION NO. So only those configurations are referred below. Based on NP's requirement `Node Operator` configuration might have to be changed and those are not referred to in this document.

Briefly the way it works is that there is a otel-collector sidecar container that runs with each ONIX node and acts like a collection buffer for OTel data. ONIX sends telemetry data to this sidecar and the sidecar then forwards it to a network otel-collector. This is where the OTel data enteres the ION Network Observability platform. Here it is stored, aggregated and presented for analysis.

## Configuring NP software for Network Observability

### Using the right NetworkId
- When NPs send messages they should use the right networkId for their environment. The networkId is used in the context section of every Beckn message. Currently the following networkIds must be used

```
Staging: ion.id/staging
Production: ion.id/prod
```

### Configuring OTel collectors

Broadly the OTel configuration procedure required for NO falls in three categories.
  - NPs who use this repository to bring up ION-ONIX containers
  - NPs who manually configure ION-ONIX image
  - NPs who do not use ION-ONIX

#### NPs who bring up ION-ONIX container from this repository
- This repository already has the right OTel network collector configuration. So nothing needs to be done if the NP has configured ONIX from this repository.

#### NPs who manually configure ONIX

If an NP manually configures ONIX, the following are the OTel related configuration. Refer to samples in the **config subfolders of bapONIX/bppONIX folders of this repo** for sample configurations.

1. Configuration within ONIX to send OTel data to sidecar. The otelsetup plugin will need to be configured.
2. An `audit-fields.yaml` file with mode as full and PII masking configured.
3. Configure sidecar otel collectors to send data in gzip format over http to the following addresses
4. Ensure that `SubscriberId` key in the various modules are properly configured.

```
Staging: https://netcol.staging.ion.id
Production: https://netcol.ion.id
```

#### NPs who do not use ION-ONIX

NPs who do not use ION-ONIX will have to send the following OTel data:
- Audit logs which contain entire Beckn message being sent/received

In your local OTel collector configuration, configure an exporter. It should export data in gzip format over http to the following addresses

```
Staging: https://netcol.staging.ion.id
Production: https://netcol.ion.id
```

### Conclusion
Network Observability is a key component of ION on which many operational observability for ION itself as well as value added functionality for NPs are based. It is based on the OTel ecosystem. ION-ONIX and this repo provide pre-configured containers and configuration to send data for NO. All NPs should configure their systems suitably to send the required OTel data to the ION Network Observability platform. 