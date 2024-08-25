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
