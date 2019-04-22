# Multi-Sig Wallet
A special contract where we can put funds but to get funds
 from this contract we will need several approvals

 
* Covers how to send and receive funds. Thats is any customer on the
network can send funds to the smart contract even without calling 
any method (fallback function).
* Users can also send funds to the smart contract through method calls

* Other smart contracts that has balances (ether value) can also send
funds to our smart contract. Consider an InvestingContract sending 
investment funds to a CrowdFunding SmartContract. Smart contracts can call
methods on other smart contracts as well and send funds with those method
calls

## Lessons

* Checking sufficiency of funds before allowing sending
```
function buyCoins(uint _coins) payable { 
    
    // Checks send amount
    require(msg.value > 1000)

    // Payment accepted
}
```

* Sending funds without calling a method
```
// called when ether is sent without calling a method 
// Thus a fallback function
function() payable{
    require(msg.value < 1000);
} 
```

* Address Type
```
address addr = msg.sender;

// Get account balance
uint accountBalance = addr.balance;

// Contracts Balance
address(this).balance;

```

* Sending Payments
```
address addr = ...;

// Reverts execution if fails
addr.transfer(1000); // weis not ether

// Second Method of payment
// Returns false if transaction fails
bool succeeded = addr.send(1000);


// Should check returned value!

```
Generally, send method is said to be unsafe and should
be avoid if you can. Please use transfer whenever possible.

## How Multi-sig Wallet works
Note that this is a simplified implementation of multi-signature wallet.

*   A user will create a smart contract and will send some amount of ether to this smart contract. The creator of this smart contract will provide a beneficiary to to whom this ether can be sent and a list of approvers who can approve or reject transactions.

```
create(amount, beneficiaries, approvers);
``` 

* Then approvers from the list can interact with smart contract to approve or reject the transaction.

* If the neccessary amount of approves the transactions then this fund will be sent to the beneficiary and if any of the approvers reject the transaction then the fund will go back to the sender to the user.


