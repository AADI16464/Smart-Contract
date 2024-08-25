# Smart Contract

This Solidity program is a "Smart Contract" for a "Bakery Shop Management System" that successfully uses the require(), assert(), and revert() statements. This contract will demonstrate how these statements can be used to ensure the correct functioning and integrity of the contract.
## Description
This Solidity smart contract represents a simple bakery shop management system. The contract allows the owner to bake and sell cakes to customers, as well as handle cake returns. It uses Solidity's built-in functions require(), assert(), and revert() to enforce conditions and handle errors effectively.
 
 The require() function is used to validate conditions and inputs in a function.If the condition fails, the function execution stops, and any changes made to the state are reverted.
 
 The revert() function is used to stop the execution of a function and revert any changes made to the state if an error condition is encountered. It also allows for a custom error message to be returned.
 
 The assert() function is used to check for conditions that should never be false. It is used for internal errors and invariants. If an assert() condition fails, it indicates a serious bug, and the function execution is halted with all changes reverted.
## Getting Started

### Executing program

To run this program, I uesd Remix which is an online Solidity IDE.

After navigating to the Remix website, I created a file named Bakery.sol, where .sol is the extension used for Solidity files. I then pasted the code below into this file.

```javascript
//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

contract Crowdfunding {
    address payable public beneficiary;
    uint public Goal;
    uint public amountRaised;
    mapping(address => uint) public contributions;
    bool public fundingGoalReached;
    bool public crowdsaleClosed;

    constructor(
        address payable _beneficiary,
        uint _Goal
    ) {
        beneficiary = _beneficiary;
        Goal = _Goal;
    }

    function contribute() public payable {
        require(!crowdsaleClosed, "Crowdsale is closed.");
        require(msg.value > 0, "Contribution must be greater than 0.");

        contributions[msg.sender] += msg.value;
        amountRaised += msg.value;
        if (amountRaised >= Goal) {
            fundingGoalReached = true;
        }
    }

    function checkGoalReached() public {
        if (!crowdsaleClosed) {
            revert("Crowdsale is not closed yet.");
        }
        if (!fundingGoalReached) {
            revert("Funding goal not reached.");
        }
        assert(amountRaised >= Goal);
        beneficiary.transfer(amountRaised);
    }

    function closeCrowdsale() public {
        require(!crowdsaleClosed, "Crowdsale is already closed.");
        crowdsaleClosed = true;
        if (amountRaised >= Goal) {
            fundingGoalReached = true;
        }
    }

    function refund() public {
        require(crowdsaleClosed, "Crowdsale is not closed.");
        require(!fundingGoalReached, "Funding goal reached, no refunds available.");

        uint amount = contributions[msg.sender];
        require(amount > 0, "No contributions to refund.");

        contributions[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
    }
}
....

To compile the code, I clicked on the "Solidity Compiler" tab in the left-hand sidebar and ensured that the compiler version was greater than or equal to "0.8.4" so that my Solidity code could run properly without any errors. Then, I clicked on the "Compile Bakery.sol" button.

After the code was compiled, I deployed the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. I selected the "Bakery" contract from the dropdown menu and then clicked on the "Deploy" button.

Once the contract was deployed, I interacted with it by giving value as input in the bakecake, sellcake and returncake functions of the "Bakery" contract. I clicked on the "Transact" button in the mint and burn functions. Then, I clicked on the "totalsupply" function to see the total supply of tokens. To check the remaining tokens in a specific wallet, I pasted the address of the wallet into the balance function and clicked on "Call".
## Summary
This smart contract effectively manages a bakery's operations, allowing for the secure baking, selling, and returning of cakes while ensuring proper error handling and integrity checks using require, assert, and revert statements. The contract demonstrates fundamental concepts in Solidity programming, including ownership control, state management, event handling, and secure Ether transfers.
## Authors
Pratap Aditya Singh

## License

This project is licensed by the MIT License.
