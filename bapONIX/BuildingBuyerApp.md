## Journey of building and testing a Buyer App
(Work in progress)

1. Identify a use case you want to work on and identify your role - buyer app or seller app (the rest of this document is for those who have identified their role as that of the Buyer)
2. Study examples related to your usecase (if available). There might be many sets (If there are multiple pattern and variants). These examples will have list of Beckn API message requests and responses along with their payload. Study these and understand the logical flow of information required to complete the transaction and the variants. 
3. Install the BAP ONIX adapter. The ONIX Adapter will provide a `/bap/caller` end point where Beckn requests can be sent. Write your software that will send messages to the Beckn network through the BAP ONIX adapter. The adapter should be configured to call back your software through a webhook. During development, if the BAP ONIX needs to be installed on the local laptop, you can install local tunnel support with the BAP ONIX. 
4. Test your software against either a sample BPP software or an available BPP on the sandbox network.
5. Devlabs portal will have unit test case scripts for many patterns and variants. Test your softare using those.
6. Devlabs portal also has compltete flow test cases. Use those to test complete flows once the unit test cases are done. 
7. Initiate onboarding to production through ION Central portal