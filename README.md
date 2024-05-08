# solidity-remix-fundme


## Description

The FundMe contract is designed to accept funds from users, store the amount of Ether each address has funded, and allow the owner to withdraw the accumulated funds. Additionally, it enforces a minimum funding threshold and ensures that only the contract owner can initiate withdrawals.

## SPDX License Identifier

The contract uses the MIT license, allowing others to freely use, modify, and distribute the code under certain conditions.

## Solidity Version

The contract is written in Solidity version ^0.8.8, ensuring compatibility with the specified compiler version.

## Imports

PriceConverter Library: The contract imports the PriceConverter library to enable conversion between different currencies, facilitating the determination of the minimum funding value.

## State Variables

- minUsd: Specifies the minimum funding value in USD with 18 decimal places to match wei.
- funders: An array of addresses to store the addresses that have sent funds to the contract.
- addressToAmountFunded: A mapping that records the amount of Ether each address has funded.
- owner: Stores the address of the contract owner.

## Constructor

Initializes the contract owner as the address of the deployer of the contract.

## Functions

- fund(): Allows users to send funds to the contract. It ensures that the sent amount meets the minimum funding requirement. The sender's address and the amount funded are stored in the addressToAmountFunded mapping.
- withdraw(): Allows the owner to withdraw the accumulated funds from the contract. It resets the mapping and array storing funders and transfers the contract balance to the owner.
- onlyOwner Modifier: Restricts access to functions to only the contract owner, preventing unauthorized withdrawals.

## Usage

- Deploy the FundMe contract.
- Users can fund the contract by sending Ether using the fund() function.
- The contract owner can withdraw accumulated funds using the withdraw() function.

## License

This contract is licensed under the MIT License, allowing free use and modification under certain conditions.