## ion-onix Repository

### Introduction
This repository contain files required to setup ONIX adapters and tools to help developers build applications on ION(Indonesia Open Network). It contains the following folders

- **bapONIX** - Contains the BAP ONIX Adapter. Used to integrate Buyer App into ION network. Run the bapONIX/configure-bap-onix.sh to configure it.

- **bppONIX** - Contains the BPP ONIX Adapter. Used to integrate Seller App into ION network. Run the bppONIX/configure-bpp-onix.sh to configure it.

- **testnet** - Contains a sandbox ION Network. Used to understand message communication, try out sample postman collection, develop on local machine etc.

- **common** - Contains common utilities such as key generator etc. 


## Running both BAP and BPP individually on the same machine
- The only complication we will have in this configuration is to make both the docker compose use the same network. There are two options. 
  1. We can create an external network first using `docker network create --driver bridge beckn-network` and mark the network as external in both the docker-compose files. In this case the order of bringing up the docker compose files does not matter.
  2. We can mark the network within the `docker-compose-BPPAdapter.yml` as external. In this case, we have to bring up the BAP first and then BPP and shutdown in the reverse order. 
- Taking Option 2 as the way ahead, the following is the order of things to be done
1. Configure BAPOnix and run the BAP docker compose.
2. Configure BPPOnix
3. Modify the docker-compose-BPPAdapter.yml and add `external=true` and remove `driver=bridge` to the beckn_network network
4. Start BAP docker compose and then BPP docker compose.
5. When you want to shutdown the two docker compose networks, first bring down the BPP docker compose network and then bring down the BAP docker compose (as the network is owned in BAP)
