## Introduction
- This folder contains the Dockerized version of BPP ONIX installation for ION networks. This can be used to install it on staging servers. There is an alternative version which uses local tunnel in bppONIXlt folder which can be used to install on local machines which cannot natively host a server. 

## Steps

1. Using the Keys tab in ION Central devlabs, generate and register keys required for Beckn. Once registered, click on the newly registered key. You will see the required information for the steps below. 
2. **Git clone** this repository. 
```
$ git clone https://github.com/indonesiaopennetwork/ion-onix.git`
```
3. Change into the bppONIX folder. 
```
$ cd bppONIX
```
4. Run the `configure_onix.sh` script(**ONIX configuration script**). It asks for the data from step 1 above as well as the private key that was downloaded as part of step 1 above. 
5. Run docker compose to bring up the adpater and support services. (Use docker-compose-BPPAdapter-LT.yml below if using local tunnel setup)
```
$ docker compose -f docker-compose-BPPAdapter.yml up --build
```
6. Refer to the `BuildingSellerApp.md` file for step by step instructions to building and testing your Seller App. 
