## Journey of building and testing a Buyer App
(Work in progress)

1. Identify a use case you want to work on and identify your role - buyer app or seller app (the rest of this document is for those who have identified their role as that of the Buyer)
2. Study examples related to your usecase (if available). There might be many sets (If there are multiple pattern and variants). These examples will have list of Beckn API message requests and responses along with their payload. Study these and understand the logical flow of information required to complete the transaction and the variants. 
3. Install the BAP ONIX adapter. 
4. Write your Buyer App software.
    - The ONIX Adapter provides a `/bap/caller` end point which can be called by your software to send Beckn requests.
    - ONIX adapter sends these messages to the ION network.
    - The adapter should be configured to call back your software through a webhook (ONIX also supports publishing onto a message queue). The configuration is in the file `config/local-simple-routing-BAPReceiver.yaml` at the key `routingRules>>target>>url`.
    - During development, if the BAP ONIX needs to be installed on the local laptop, you will need local tunnel support (ngrok,localtunnel etc) with the BAP ONIX. 
5. Test your software against either a sample BPP software or an available BPP on the sandbox network.
6. Devlabs portal will have unit test case scripts for many patterns and variants. Test your softare using those.
7. Devlabs portal also has compltete flow test cases. Use those to test complete flows once the unit test cases are done. 
8. Initiate onboarding to production through ION Central portal