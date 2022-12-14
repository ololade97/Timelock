//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Timelock {
  mapping(address => uint) public balances;
  mapping(address => uint) public lockTime;

// Function allows people to deposit Ether and lock Ether
  function deposit() external payable {
   balances[msg.sender] += msg.value;

   // You can change the 2 minutes to 1 hours, 2 weeks, or 3 years Ether lock time
   lockTime[msg.sender] = block.timestamp + 2 minutes;
  } 


// Function allows you to withdraw when lock time is up
  function withdraw() public {
      require(balances[msg.sender] > 0, "You don't have fund");
      require(block.timestamp > lockTime[msg.sender], "Lock time not expired");

      uint amount = balances[msg.sender];
      balances[msg.sender] = 0;

      // This allows you to transfer Ether
      (bool sent, ) = msg.sender.call{value: amount} ("");
      require(sent, "Ether not sent");
  }
}
