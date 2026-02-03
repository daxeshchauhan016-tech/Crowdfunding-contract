// SPDX-License-Identifier: MIT
pragma solidity ^0.8.31;

contract Crowdfunding {
    address public owner;
    uint public goal;
    uint public deadline;
    uint public totalFunded;

    struct Contribution {
        uint amount;
    }

    mapping(address => Contribution) public contributions;

    constructor(uint _goal, uint _durationInSeconds) {
        owner = msg.sender;
        goal = _goal;
        deadline = block.timestamp + _durationInSeconds;
    }

    event Funded(address indexed funder, uint amount);

    function fund() public payable {
        require(block.timestamp < deadline, "Funding ended");
        require(msg.value > 0, "Send ETH");

        contributions[msg.sender].amount += msg.value;
        totalFunded += msg.value;

        emit Funded(msg.sender, msg.value);
    }

    function goalReached() public view returns (bool) {
        return totalFunded >= goal;
    }

    function fundingEnded() public view returns (bool) {
        return block.timestamp >= deadline;
    }

    function withdraw() public {
        require(msg.sender == owner, "Not owner");
        require(fundingEnded(), "Funding still active");
        require(goalReached(), "Goal not reached");

        uint amount = address(this).balance;

        (bool success,) = payable(owner).call{value: amount}("");
        require(success, "ETH transfer failed");
    }

    function refund() public {
    require(fundingEnded(), "Funding still active");
    require(!goalReached(), "Goal reached, no refunds");

    uint amount = contributions[msg.sender].amount;
    require(amount > 0, "No funds to refund");

    contributions[msg.sender].amount = 0;
    
    (bool success,) = payable(owner).call{value: amount}("");
        require(success, "ETH transfer failed");
    }


}
