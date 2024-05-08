// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

// libraries can't have state values and can't send ether
// all libraires functions need to be internal
library PriceConverter {

     // function to get the price of eth
    function getPrice() internal view returns(uint256) {
        // to call the chainlink oracle, we need:
        // ABI
        // we get the address from the chainlink docs
        // https://docs.chain.link/data-feeds/price-feeds/addresses?network=ethereum&page=1
        // Address 0x694AA1769357215DE4FAC081bf1f309aDC325306

        // create an instance of the aggregator called priceFeed injecting the contract addy from chainlink
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);

        // call the function latestRoundData from the CL contract
        // you get the returned value by looking at the interface code
        // this structure is called a tuple, every comma is meant to skip variables in their position that I don't need
       (, int256 price,,, ) = priceFeed.latestRoundData();

       return uint256(price * 1e10); //msg.value has 18 decimals 1e18, but I need 8 decimals so I multiply for 10 (the decimals I want out)
       // price is an int256, so I need to typecast the return by adding uint256
    }

    // function to convert 50 usd to eth
    function getConversion(uint256 ethAmount) internal view returns(uint256) {
        uint256 ethPrice = getPrice();
        // eth price: 3000.000000000000000000 (18 zeroes)
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }

}