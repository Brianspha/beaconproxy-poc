// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

interface IGameFactory {
    function latestGame() external view returns (address);
    function gameDeployed(address game) external view returns (bool);
    function createGame() external returns (address);
}
