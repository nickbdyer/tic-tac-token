// SPDX-License-Identifier: Unlicense                                                 |
pragma solidity ^0.8.0;
import "ds-test/test.sol";

import "../../Prime.sol";
import "./Hevm.sol";

abstract contract PrimeTest is DSTest {
    Hevm internal constant hevm = Hevm(HEVM_ADDRESS);

    PrimeFactors internal prime;

    function setUp() public virtual {
        prime = new PrimeFactors();
    }
}