/**
 * @title Securus Store
 * @dev SecurusStore contract
 *
 * @author Felix Götz - <AUREUM VICTORIA>
 * on behalf of Securus Technologies LLC
 *
 * SPDX-License-Identifier: GNU GPLv2
 *
 **/

pragma solidity 0.8.4;

import "./Ownable.sol";
import "./INFT.sol";
import "./IERC20.sol";
import "./IReferrals.sol";
import "./IWhitelist.sol";
import "./IBlacklist.sol";
import "./ITermsOfService.sol";

/**
 * @dev Contract for new NFT drops. SecurusDrop must be authorized to mint new NFTs of the specified
 * NFT contract (_nftAddress). You also have to be carefull of IDs you set. Since this contract
 * assumes offchain reservation of IDs. Meaning when you add drops you need to consider if NFT ids
 * will be available when buying.
 */
contract SecurusStore is Ownable {
    struct Drop {
        uint256 totalSupply;
        uint256 idCounter;
        uint256 nftId;
        uint256 startTime;
        address nftAddress;
        address paymentCoin;
        address receiverAddress;
        uint256 price;
        uint256 Storelevel;
    }

    struct RefLevel {
        uint256 level1;
        uint256 level2;
        uint256 level3;
        uint256 level4;
        uint256 level5;
        uint256 level6;
    }

    /**
     * @dev Address that will receive tokens from bought NFTs.
     */
    address private _receiverAddress;

    /**
     * @dev Address that will mint NFTs.
     */
    INFT internal SecurusNFT;

    /**
     * @dev  Referrals Interface.
     */
    IReferrals public referrals;
    IWhitelist public whitelist;
    IBlacklist public blacklist;
    ITermsOfService public TermsOfService;

    /**
     * @dev List of drops.
     */
    Drop[] public drops;
    RefLevel[] public RefLevels;
    bool public statusStoreWhitelist;

    /**
     * @dev Implements ERC721 contract and sets default values.
     */
    constructor() {}

    /**
     * @dev add new drop.
     *
     * Requirements:
     *
     * `uint256` or `address` cannot be the empty.
     */
    function addDrop(
        uint256 totalSupply,
        uint256 idCounter,
        uint256 nftId,
        uint256 startTime,
        address nftAddress,
        address paymentCoin,
        address receiverAddress,
        uint256 price,
        uint256 Storelevel
    ) external onlyOwner {
        Drop memory d = Drop(
            totalSupply,
            idCounter,
            nftId,
            startTime,
            nftAddress,
            paymentCoin,
            receiverAddress,
            price,
            Storelevel
        );
        drops.push(d);
    }

    /**
     * @dev add new referral level.
     *
     * Requirements:
     *
     * `uint256` cannot be the empty.
     */
    function addRefLevel(
        uint256 level1,
        uint256 level2,
        uint256 level3,
        uint256 level4,
        uint256 level5,
        uint256 level6
    ) external onlyOwner {
        RefLevel memory r = RefLevel(
            level1,
            level2,
            level3,
            level4,
            level5,
            level6
        );
        RefLevels.push(r);
    }

    /**
     * @dev update the drop.
     *
     * Requirements:
     *
     * `uint256` or `uint` cannot be the empty.
     */
    function UpdateTotalSupply(uint256 dropIndex, uint256 _totalSupply)
        public
        onlyOwner
    {
        drops[dropIndex].totalSupply = _totalSupply;
    }

    function UpdateIdCounter(uint256 dropIndex, uint256 _idCounter)
        public
        onlyOwner
    {
        drops[dropIndex].idCounter = _idCounter;
    }

    function UpdateNftId(uint256 dropIndex, uint256 _nftId) public onlyOwner {
        drops[dropIndex].nftId = _nftId;
    }

    function UpdateStartTime(uint256 dropIndex, uint256 _startTime)
        public
        onlyOwner
    {
        drops[dropIndex].startTime = _startTime;
    }

    function UpdateNftAddress(uint256 dropIndex, address _nftAddress)
        public
        onlyOwner
    {
        drops[dropIndex].nftAddress = _nftAddress;
    }

    function UpdatePaymentCoin(uint256 dropIndex, address _paymentCoin)
        public
        onlyOwner
    {
        drops[dropIndex].paymentCoin = _paymentCoin;
    }

    function UpdateReceiverAddress(
        uint256 dropIndex,
        address _newReceiverAddress
    ) public onlyOwner {
        drops[dropIndex].receiverAddress = _newReceiverAddress;
    }

    function UpdatePrice(uint256 dropIndex, uint256 _price) public onlyOwner {
        drops[dropIndex].price = _price;
    }

    /**
     * @dev update the external smart contracts.
     *
     * Requirements:
     *
     * `address` or cannot be the empty or 0x0.
     */
    function UpdateReferralsContract(address _referralsContract)
        public
        onlyOwner
    {
        referrals = IReferrals(_referralsContract);
    }

    function UpdateWhitelistContract(address _whitelistContract)
        public
        onlyOwner
    {
        whitelist = IWhitelist(_whitelistContract);
    }

    function UpdateBlacklistContract(address _blacklistContract)
        public
        onlyOwner
    {
        blacklist = IBlacklist(_blacklistContract);
    }

    function UpdateTermsOfService(address _TermsOfService) public onlyOwner {
        TermsOfService = ITermsOfService(_TermsOfService);
    }

    /**
     * @dev Removes and existing drop.
     * @param index Index of the drop we are removing.
     */
    function removeDrop(uint256 index) external onlyOwner {
        delete drops[index];
    }

    /**
     * verifies that the caller is not a contract.
     */
    modifier onlyEOA() {
        require(msg.sender == tx.origin, "!EOA");
        _;
    }

    /**
     * @dev set the whitelist true or false.
     *
     * Requirements:
     *
     * bool `_statusStoreWhitelistIs` can be true or false.
     */
    function statusStoreWhitelistIs(bool _statusStoreWhitelistIs)
        public
        onlyOwner
    {
        statusStoreWhitelist = _statusStoreWhitelistIs;
    }

    /**
     * @dev Buy a NFT from drop X with sponsor.
     * sponsor from sender get ref payment.
     *
     * Requirements:
     *
     * address `_sponsor` cannot be the empty.
     * uint256 `dropIndex` must exist.
     */
    function buy(uint256 dropIndex, address _sponsor) external onlyEOA {
        address _sponsor1;
        Drop memory d = drops[dropIndex];
        RefLevel memory r = RefLevels[dropIndex];

        require(
            TermsOfService.hasAcceptedTermsOfService(msg.sender) == true,
            "You have not accepted the Terms of Service"
        );
        require(
            whitelist.isWhitelisted(msg.sender) == true ||
                statusStoreWhitelist == false ||
                whitelist.statusWhitelist() == false,
            "You are not Whitelisted"
        );
        require(
            blacklist.isBlacklisted(msg.sender) == false,
            "You are Blacklisted"
        );
        require(block.timestamp >= d.startTime, "Drop not yet available.");
        require(d.totalSupply > d.idCounter, "No more editions available.");
        drops[dropIndex].nftId++;
        drops[dropIndex].idCounter++;
        INFT _token = INFT(address(d.nftAddress));
        IERC20 paymentCoins = IERC20(address(d.paymentCoin));

        _sponsor1 = referrals.getSponsor(msg.sender);

        if (referrals.isMember(msg.sender) == false) {
            //wenn sender kein member

            if (referrals.isMember(_sponsor) == true) {
                //wenn _sponsor ist member
                referrals.addMember(msg.sender, _sponsor); // füge sponsor den member hinzu
                _sponsor1 = _sponsor;
            } else if (referrals.isMember(_sponsor) == false) {
                //wenn _sponsor kein member
                _sponsor1 = referrals.membersList(0);
            }
        }

        paymentCoins.transferFrom(
            msg.sender,
            d.receiverAddress,
            (d.price / 100) * d.Storelevel
        );

        if (r.level1 > 0) {
            paymentCoins.transferFrom(
                msg.sender,
                _sponsor1,
                (d.price / 100) * r.level1
            );
            address _sponsor2 = referrals.getSponsor(_sponsor1);

            if (r.level2 > 0) {
                paymentCoins.transferFrom(
                    msg.sender,
                    _sponsor2,
                    (d.price / 100) * r.level2
                );
                address _sponsor3 = referrals.getSponsor(_sponsor2);

                if (r.level3 > 0) {
                    paymentCoins.transferFrom(
                        msg.sender,
                        _sponsor3,
                        (d.price / 100) * r.level3
                    );
                    address _sponsor4 = referrals.getSponsor(_sponsor3);

                    if (r.level4 > 0) {
                        paymentCoins.transferFrom(
                            msg.sender,
                            _sponsor4,
                            (d.price / 100) * r.level4
                        );
                        address _sponsor5 = referrals.getSponsor(_sponsor4);

                        if (r.level5 > 0) {
                            paymentCoins.transferFrom(
                                msg.sender,
                                _sponsor5,
                                (d.price / 100) * r.level5
                            );
                            address _sponsor6 = referrals.getSponsor(_sponsor5);

                            if (r.level6 > 0) {
                                paymentCoins.transferFrom(
                                    msg.sender,
                                    _sponsor6,
                                    (d.price / 100) * r.level6
                                );
                            }
                        }
                    }
                }
            }
        } else {}

        _token.mint(msg.sender, drops[dropIndex].nftId);
    }

    /**
     * @dev Returns the count of all existing Drops.
     * @return Total supply of NFTs.
     */
    function getDropCount() external view returns (uint256) {
        return drops.length;
    }
}