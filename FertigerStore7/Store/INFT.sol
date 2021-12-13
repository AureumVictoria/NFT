/**
 * @title Interface Non-Fungible Token
 * @dev INFT contract
 *
 * @author Felix Götz - <AUREUM VICTORIA>
 * on behalf of Securus Technologies LLC
 *
 * SPDX-License-Identifier: GNU GPLv2
 *
 **/

pragma solidity ^0.8.4;

interface INFT {
    function updateLicence(uint256 tokenId) external;

    function mint(address to, uint256 tokenId) external;

    function tokenURI(uint256 tokenId) external view returns (bool);

    function StartLizenzBlock(uint256 tokenId) external view returns (uint256);

    function EndLizenzBlock(uint256 tokenId) external view returns (uint256);

    function CheckLizenzDays(uint256 tokenId) external view returns (uint256);

    function CheckLizenzAktiv(uint256 tokenId) external view returns (bool);

    function Timestamp() external view returns (uint256);

    function _baseURI() external view returns (string memory);
}