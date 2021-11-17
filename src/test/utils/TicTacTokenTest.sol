// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "ds-test/test.sol";

import "../../TicTacToken.sol";
import "./Hevm.sol";

abstract contract TicTacTokenTest is DSTest {
    Hevm internal constant hevm = Hevm(HEVM_ADDRESS);

    // contracts
    TicTacToken internal ttt;

    function setUp() public virtual {
        ttt = new TicTacToken();
    }
}