//SPDX-Licence-Identifier: MIT

// This is considered an Exogenous, Decentralized, Anchored (pegged), Crypto Collateralized low volitility coin

// Layout of Contract:
// version
// imports
// interfaces, libraries, contracts
// errors
// Type declarations
// State variables
// Events
// Modifiers
// Functions

// Layout of Functions:
// constructor
// receive function (if exists)
// fallback function (if exists)
// external
// public
// internal
// private
// view & pure functions


pragma solidity ^0.8.18;


import{ERC20Burnable, ERC20} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import{Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/**
* @title Decentralised Stable Coin
* @author Nitin Chaddha
* Collateral: Exogenous(Eth & BTC)
* Minting: Algorithmic
* Relative Stability: Pegged to USD
* 
*/

contract DecentralisedStableCoin is ERC20Burnable, Ownable {


    constructor() ERC20("DecentralisedStableCoin", "DSC") Ownable(msg.sender) {}

    error DecentralisedStableCoin__MustBeMoreThanZero();
    error DecentralisedStableCoin__BurnAmountExceedsBalance();
    error DecentralisedStableCoin__NotZeroAddress();
    

    function burn(uint256 _amount) public override onlyOwner {
        uint256 balance = balanceOf(msg.sender);
        if(_amount <= 0) {
            revert DecentralisedStableCoin__MustBeMoreThanZero();
        }
        if(balance < _amount) {
            revert DecentralisedStableCoin__BurnAmountExceedsBalance();
        }
    super.burn(_amount);
    }

    function mint(address _to, uint256 _amount) public onlyOwner returns(bool) {
        if(_to == address(0)) {
            revert DecentralisedStableCoin__NotZeroAddress();
        }

        if(_amount <= 0) {
            revert DecentralisedStableCoin__MustBeMoreThanZero();
        }

        _mint(_to, _amount);
        return true;
    }
}