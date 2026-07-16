## Introduction
- This folder contains the Dockerized version of BAP ONIX installation for ION networks. 

## Steps to configure and run BAPAdapter

1. Using the setup tab in ION Central devlabs, generate and register keys required for Beckn. Once registered, click on the newly registered key. You will see the required information for the steps below. 
2. **Git clone** this repository. 
```
$ git clone https://github.com/indonesiaopennetwork/ion-onix.git`
```
3. Change into the bapONIX folder. 
```
$ cd bapONIX
```
4. Run the `configure-bap-onix.sh` script(**BAP ONIX configuration script**). It asks for the data from step 1 above as well as the private key that was downloaded as part of step 1 above. 
5. Run docker compose to bring up the adpater and support services.
```
$ docker compose -f docker-compose-BAPAdapter.yml up --build
```
6. Refer to the `BuildingBuyerApp.md` file for step by step instructions to building and testing your Buyer App. 


