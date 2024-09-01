//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {DecentralisedStableCoin} from "../src/DecentralisedStableCoin.sol";
import {DSCEngine} from "../src/DSCEngine.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract DeployDSC is Script {
    address[] public tokenAddresses;
    address[] public priceFeedAddresses;

    function run()
        external
        returns (DecentralisedStableCoin, DSCEngine, HelperConfig)
    {
        HelperConfig config = new HelperConfig();

        (
            address wethUsdPriceFeed,
            address wbtcPriceFeed,
            address weth,
            address wbtc,
            uint256 deployerKey
        ) = config.activeNetworkConfig();

        priceFeedAddresses = [wethUsdPriceFeed, wbtcPriceFeed];
        tokenAddresses = [weth, wbtc];

        vm.startBroadcast();
        DecentralisedStableCoin dsc = new DecentralisedStableCoin();
        DSCEngine engine = new DSCEngine(
            tokenAddresses,
            priceFeedAddresses,
            address(dsc)
        );

        dsc.transferOwnership(address(engine));
        vm.stopBroadcast();
        return (dsc, engine, config);
    }
}
