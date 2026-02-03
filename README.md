# Crowdfunding Smart Contract

## Overview
This smart contract allows users to fund a campaign with ETH.
If the funding goal is reached before the deadline, the owner can withdraw funds.
If the goal is not reached, contributors can claim refunds.

## Features
- Public funding
- Funding goal & deadline
- Secure owner withdrawal
- Refunds for contributors
- Event logging for frontend integration

## Key Functions
- fund(): Contribute ETH to the campaign
- withdraw(): Owner withdraws funds after success
- refund(): Contributors claim refund if campaign fails

## Use Cases
- Startup fundraising
- Community projects
- DAO funding experiments

## Tech Stack
- Solidity ^0.8.x
- Remix IDE
- Ethereum Sepolia Testnet
