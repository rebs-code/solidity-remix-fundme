// SPDX-License-Identifier: MIT
pragma solidity  ^0.8.8;

// import the PriceConverter library
import './PriceConverter.sol';


// get funds from users
// withdraw funds
// get a minimum funding value in usdt
contract FundMe {
    
    // set the library to be used for uint256 data types
    using PriceConverter for uint256;
    //set min value in dollars with 18 decimals to match wei
    uint256 public minUsd = 50 * 1e18;
    // create an array of addresses to store the addresses that sent us funds
    address[] public funders;
    // mapping of how much eth each addy sent
    mapping(address => uint256) public addressToAmountFunded;
    // set owner address
    address public owner;
    // set a constructor
    constructor(){
        owner = msg.sender; // the msg.sender of the constructor will be whoever deploys the contract
    }
    // function to get funded, public and payable to indicate it accepts msg.value payments
    function fund() public payable {
        //money math is done in wei, so 1e18 = 1eth
        //msg.value indicates the value sent
        //require means that this function requires the msg.value to be at least 1eth
        //if value is not > 1e18, function is going to rever with message "Not enough eth sent"
        // when a function reverts, it undoes every action before and sends remaining gas back
        require(msg.value.getConversion() >= minUsd, "Not enough eth sent");

        //push the addresses that sent to our array
        funders.push(msg.sender);

        // populate the mapping
        addressToAmountFunded[msg.sender] = msg.value;
    }
    
    function withdraw() public onlyOwner {
        // loop through founders and reset the mapping 
        for (uint256 i = 0; i < funders.length; i++) {
            addressToAmountFunded[funders[i]] = 0;
        }

        // reset founder array
        funders = new address[](0); //funders is now a new array of type address with 0 objects inside

        // withdraw with call
        // this function returns two values, but we just gonna use callSuccess so we use tuples again to extract it
        (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Is not owner!");
        _; // this underscore represents "doing the rest of the code"
    }
    
}
