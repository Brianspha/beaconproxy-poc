// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {IGameFactory} from "./IGameFactory.sol";
import {AnotherGame} from "./AnotherGame.sol";

contract GameFactoryBase is IGameFactory, UUPSUpgradeable, OwnableUpgradeable {
    mapping(address => bool) public deployedGames;
    address[] public games;
    /// @custom:oz-upgrades-unsafe-allow constructor

    constructor() {
        _disableInitializers();
    }

    function __GameFactoryBase_init() public onlyInitializing {
        __UUPSUpgradeable_init();
        __Ownable_init();
    }

    function latestGame() external view override returns (address) {
        return games[games.length - 1];
    }
    function gameDeployed(address game) public view override returns (bool) {
        return deployedGames[game];
    }
    function createGame() external returns (address) {
        AnotherGame game = new AnotherGame();
        games.push(address(game));
        deployedGames[address(game)] = true;
        return address(game);
    }

    function _authorizeUpgrade(
        address newImplementation
    ) internal override onlyOwner {}
}
