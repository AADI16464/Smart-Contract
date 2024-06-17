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
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract BakeryShop 
{
    address public owner;
    uint public totalCakes;
    mapping(address => uint) public customerCakes;

    event CakeBaked(uint quantity);
    event CakeSold(address indexed customer, uint quantity);
    event CakeReturned(address indexed customer, uint quantity);

    constructor() 
    {
        owner = msg.sender;
    }

    // Function to bake cakes, only owner can bake
    function bakeCakes(uint quantity) public 
    {
        require(msg.sender == owner, "Only owner can bake cakes");
        require(quantity > 0, "Quantity must be greater than zero");
        
        totalCakes += quantity;
        emit CakeBaked(quantity);
    }

    // Function to sell cakes
    function sellCakes(uint quantity) public payable
    {
        require(quantity > 0, "Quantity must be greater than zero");
        require(totalCakes >= quantity, "Not enough cakes in stock");
        require(msg.value <= quantity * 0.5 ether, "Insufficient payment, 0.5 ether per cake");

        totalCakes -= quantity;
        customerCakes[msg.sender] += quantity;
        emit CakeSold(msg.sender, quantity);
    }

    // Function to return cakes
    function returnCakes(uint quantity) public 
    {
        require(quantity > 0, "Quantity must be greater than zero");
        require(customerCakes[msg.sender] >= quantity, "You don't have enough cakes to return");

        customerCakes[msg.sender] -= quantity;
        totalCakes += quantity;

        // Refund ether to the customer
        uint refundAmount = quantity * 0.5 ether;
        (bool success, ) = msg.sender.call{value: refundAmount}("");
        if (!success) {
            revert("Refund failed");
        }
        
        emit CakeReturned(msg.sender, quantity);
    }

    // Function to withdraw all funds (only owner)
    function withdrawFunds() public 
    {
        require(msg.sender == owner, "Only owner can withdraw funds");
        uint balance = address(this).balance;

        // Ensure the contract has a positive balance before withdrawing
        assert(balance > 0);

        (bool success, ) = owner.call{value: balance}("");
        if (!success) {
            revert("Withdrawal failed");
        }
    }

    // Fallback function to receive ether
    receive() external payable {}
}

```

To compile the code, I clicked on the "Solidity Compiler" tab in the left-hand sidebar and ensured that the compiler version was greater than or equal to "0.8.4" so that my Solidity code could run properly without any errors. Then, I clicked on the "Compile Bakery.sol" button.

After the code was compiled, I deployed the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. I selected the "Bakery" contract from the dropdown menu and then clicked on the "Deploy" button.

Once the contract was deployed, I interacted with it by giving value as input in the bakecake, sellcake and returncake functions of the "Bakery" contract. I clicked on the "Transact" button in the mint and burn functions. Then, I clicked on the "totalsupply" function to see the total supply of tokens. To check the remaining tokens in a specific wallet, I pasted the address of the wallet into the balance function and clicked on "Call".
## Summary
This smart contract effectively manages a bakery's operations, allowing for the secure baking, selling, and returning of cakes while ensuring proper error handling and integrity checks using require, assert, and revert statements. The contract demonstrates fundamental concepts in Solidity programming, including ownership control, state management, event handling, and secure Ether transfers.
## Authors
Pratap Aditya Singh

## License

This project is licensed by the MIT License.
