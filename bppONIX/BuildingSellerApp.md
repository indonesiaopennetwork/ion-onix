## Journey of building and testing a Seller App
(Work in progress)

1. Identify a use case you want to work on and identify your role - buyer app or seller app (the rest of this document is for those who have identified their role as that of the Seller App)
2. Study examples related to your usecase (if available). There might be many sets (If there are multiple pattern and variants). These examples will have list of Beckn API message requests and responses along with their payload. Study these and understand the logical flow of information required to complete the transaction and the variants. 
3. Install the BPP ONIX adapter. The BPP ONIX adapter calls your software through webhook. The ONIX Adapter will provide a `/bpp/caller` end point where your software can send back responses to the network. Write your software to code the seller side logic.During development, if the BPP ONIX needs to be installed on the local laptop, you can install local tunnel support with the BPP ONIX. 
4. Test your software using postman, or a sample BAP software or an available BAP on the sandbox network.
5. Devlabs portal will have unit test case scripts for many patterns and variants. Test your softare using those.
6. Devlabs portal also has compltete flow test cases. Use those to test complete flows once the unit test cases are done. 
7. Initiate onboarding to production through ION Central portal