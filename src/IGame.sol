// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

interface IGame {
    event GameStarted(uint256 indexed timestamp, address indexed player);

    error NotImplemented();
    error Unauthorized();
    function __Game_init() external;
    function startGame(address player) external returns (bool);
    function addPlayer(address player) external returns (bool);
    function removePlayer(address player) external returns (bool);
    function collectRewards() external returns (bool);
    function whiteListWallet(
        address wallet,
        bool status
    ) external returns (bool);
    function healthCheck() external view returns (bool);
}
