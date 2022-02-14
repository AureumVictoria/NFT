/**
 * @title Interface dont Trigger
 * @dev IDontTrigger contract
 *
 * @author - <AUREUM VICTORIA GROUP>
 * for the Securus Foundation 
 *
 * SPDX-License-Identifier: GNU GPLv2
 *
 **/

pragma solidity ^0.6.12;

interface ITeamMember1 {

    function isTokenAddressOK() external view returns (address);

    function isTokenBalanceOK() external view returns (uint256);

    function isTokenWithdrawlAddressOK() external view returns (address);

    function isVetoMember1() external view returns (bool);

    function isVetoMember2() external view returns (bool);

    function isVetoMember3() external view returns (bool);

    function isVetoMember4() external view returns (bool);
}

interface ITeamMember2 {

    function isTokenAddressOK() external view returns (address);

    function isTokenBalanceOK() external view returns (uint256);

    function isTokenWithdrawlAddressOK() external view returns (address);
    
    function isVetoMember1() external view returns (bool);

    function isVetoMember2() external view returns (bool);

    function isVetoMember3() external view returns (bool);

    function isVetoMember4() external view returns (bool);
}

interface ITeamMember3 {

    function isTokenAddressOK() external view returns (address);

    function isTokenBalanceOK() external view returns (uint256);

    function isTokenWithdrawlAddressOK() external view returns (address);
    
    function isVetoMember1() external view returns (bool);

    function isVetoMember2() external view returns (bool);

    function isVetoMember3() external view returns (bool);

    function isVetoMember4() external view returns (bool);
}

interface ITeamMember4 {

    function isTokenAddressOK() external view returns (address);

    function isTokenBalanceOK() external view returns (uint256);

    function isTokenWithdrawlAddressOK() external view returns (address);
    
    function isVetoMember1() external view returns (bool);

    function isVetoMember2() external view returns (bool);

    function isVetoMember3() external view returns (bool);

    function isVetoMember4() external view returns (bool);
}