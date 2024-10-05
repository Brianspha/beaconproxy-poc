// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {IGame} from "./IGame.sol";

contract Game is IGame, UUPSUpgradeable, OwnableUpgradeable {
    modifier onlyPlayerAdded() {
        if (!players[msg.sender]) {
            revert Unauthorized();
        }
        _;
    }

    modifier onlyWhiteListed() {
        if (!whiteList[msg.sender]) {
            revert Unauthorized();
        }
        _;
    }

    mapping(address => bool) public players;
    mapping(address => bool) public whiteList;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function whiteListWallet(address wallet, bool status) public override onlyOwner returns (bool) {
        whiteList[wallet] = status;
        return true;
    }

    function __Game_init() public override onlyInitializing {
        __UUPSUpgradeable_init();
        __Ownable_init();
    }

    function startGame(address player) public override onlyPlayerAdded onlyWhiteListed returns (bool) {
        emit GameStarted(block.timestamp, player);
        return true;
    }

    function addPlayer(address player) public override onlyOwner returns (bool) {
        players[player] = true;
        return true;
    }

    function removePlayer(address player) public virtual override onlyOwner returns (bool) {
        revert NotImplemented();
    }

    function collectRewards() external virtual override returns (bool) {
        return true;
    }

    function healthCheck() public view override returns (bool) {
        return true;
    }

    function _authorizeUpgrade(address newImplementation) internal override onlyOwner {}
}
