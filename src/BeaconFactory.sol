// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {BeaconProxy} from "@openzeppelin/contracts/proxy/beacon/BeaconProxy.sol";
import {UpgradeableBeacon} from "@openzeppelin/contracts/proxy/beacon/UpgradeableBeacon.sol";

/// @dev THIS CONTRACT IS FOR LEARNING PURPOSES ONLY
contract BeaconFactory is UpgradeableBeacon {
    constructor(address _implementation) UpgradeableBeacon(_implementation, msg.sender) {}

    function createBeaconProxy(bytes memory data) external onlyOwner returns (address) {
        BeaconProxy proxy = new BeaconProxy(address(this), data);
        return address(proxy);
    }
}
