// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {IWallet} from "./IWallet.sol";
import {IGame} from "./IGame.sol";

contract Wallet is IWallet, UUPSUpgradeable, OwnableUpgradeable {
    modifier gameInitialized() {
        if (address(game) == address(0)) {
            revert GameNotInitialized();
        }
        _;
    }

    modifier onlyPartialOwner() {
        if (!owners[msg.sender]) {
            revert Unauthorized();
        }
        _;
    }

    mapping(address => bool) public owners;
    IGame public game;
    /// @custom:oz-upgrades-unsafe-allow constructor

    constructor() {
        _disableInitializers();
    }

    function __Wallet_init() public onlyInitializing {
        __UUPSUpgradeable_init();
        __Ownable_init();
    }

    function addUserToWallet(address user) public override onlyOwner {
        owners[user] = true;
    }

    function isWalletOwner(address user) public view override returns (bool) {
        return owners[user];
    }

    function playGame() public override onlyPartialOwner gameInitialized {
        bool success = game.startGame(address(this));
        if (!success) {
            revert GameCallFailed();
        }
    }

    function collectRewards() public override onlyPartialOwner gameInitialized {
        bool success = game.collectRewards();
        if (!success) {
            revert GameCallFailed();
        }
    }

    function _authorizeUpgrade(address newImplementation) internal override onlyOwner {}
}
