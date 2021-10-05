// SPDX-License-Identifier: MIT

import "./Ownable.sol";
import "./BlacklistRole.sol";

pragma solidity  0.8.4;

contract Blacklist is Ownable, BlacklistRole {
    
    mapping(address => bool) blacklist;
    event AddedToBlacklist(address indexed account);
    event RemovedFromBlacklist(address indexed account);

    modifier onlyBlacklisted() {
        require(isBlacklisted(msg.sender));
        _;
    }

    /**
     * @dev add address to the Blacklist.
     * 
     * Requirements:
     * 
     * address `account` cannot be the zero address.
     */
    function addToBlacklist(address _address) public onlyBlacklister {
        blacklist[_address] = true;
        emit AddedToBlacklist(_address);
    }

    /**
     * @dev Remove address from Blacklist.
     * 
     * Requirements:
     * 
     * address `account` cannot be the zero address.
     */
    function removeFromBlacklist(address _address) public onlyBlacklister {
        blacklist[_address] = false;
        emit RemovedFromBlacklist(_address);
    }

    /**
     * @dev Returns address is Blacklist true or false
     * 
     * Requirements:
     * 
     * address `account` cannot be the zero address.
     */
    function isBlacklisted(address _address) public view returns(bool) {
        return blacklist[_address];
    }
} 