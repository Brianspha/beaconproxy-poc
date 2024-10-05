// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

interface IWallet {
    event WalletCreated(uint256 indexed timestamp);

    error Unauthorized();
    error GameCallFailed();
    error GameNotInitialized();
    error NotImplemented();

    function addUserToWallet(address user) external;
    function isWalletOwner(address user) external returns (bool);
    function playGame() external;
    function collectRewards() external;
}
