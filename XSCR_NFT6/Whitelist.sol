// SPDX-License-Identifier: MIT

import "./Ownable.sol";
import "./WhitelistRole.sol";

pragma solidity  0.8.4;

contract Whitelist is Ownable, WhitelistRole {


bool public theWhitelist;

    /**
     * @dev set the whitelist true or false.
     * 
     * Requirements:
     * 
     * address `account` cannot be the zero address.
     */
    function theWhitelistIs(bool _isWhitelist) public onlyAuthorized() {
    theWhitelist = _isWhitelist;
   
  }
  
    mapping(address => bool) whitelist;
    event AddedToWhitelist(address indexed account);
    event RemovedFromWhitelist(address indexed account);

    modifier onlyWhitelisted() {
        require(isWhitelisted(msg.sender));
        _;
    }

    /**
     * @dev add address to the whitelist.
     * 
     * Requirements:
     * 
     * address `account` cannot be the zero address.
     */
    function addToWhitelist(address _address) public onlyWhitelister {
        whitelist[_address] = true;
        emit AddedToWhitelist(_address);
    }
    
    /**
     * @dev Remove address from whitelist.
     * 
     * Requirements:
     * 
     * address `account` cannot be the zero address.
     */
    function removeFromWhitelist(address _address) public onlyWhitelister {
        whitelist[_address] = false;
        emit RemovedFromWhitelist(_address);
    }

    /**
     * @dev Returns address is whitelist true or false
     * 
     * Requirements:
     * 
     * address `account` cannot be the zero address.
     */
    function isWhitelisted(address _address) public view returns(bool) {
        return whitelist[_address];
    }
    
}