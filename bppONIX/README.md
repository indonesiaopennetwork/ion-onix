## Introduction
- This folder contains the Dockerized version of BPP ONIX installation for ION networks. This can be used to install it on staging servers. There is an alternative version which uses local tunnel in bppONIXlt folder which can be used to install on local machines which cannot natively host a server. 

## Steps
1. **Git clone** this repository. `$ git clone https://github.com/indonesiaopennetwork/ionONIX.git`

2. **Generate Public Private Key Pair** to be used for signing. Use one of either the go utility(preferred) or the command line script to generate keys. Copy both the private and public keys. 

```
$ cd ionONIX/common

$ go run generate-ed25519-keys.go
or
$ ./generate-ed25519-keys.sh

```

3. Use the **ION-Central devlabs portal to register Beckn Keys**. You will need to provide a subscriber_url (e.g. https://bpp.mycompany.com), subscirber_id (e.g. bpp.mycompany.com) and the public key from the one generated in step 2 above. On successful creation, you will get the following from ion-central portal
```
subscriber_id     - same as what you typed in this step
subscriber_url    - same as what you typed in this step
public_key        - same as what you typed in this step
keyId             - An id generated when ION-Central devlabs portal registers your details with Registry. 
```

4. Run the Run the `configure_onix.sh` script(**ONIX configuration script**). It asks for the above data from step 3 above as well as the private key from step 2 above. 
5. Run the **docker compose** through `$ docker compose -f docker-compose-BPPAdapter.yml up --build`

