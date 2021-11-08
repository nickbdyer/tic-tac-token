// SPDX-License-Identifier: Unlicense                                                 |
pragma solidity ^0.8.0;

import "./utils/PrimeTest.sol";

contract TestPrimeFactors is PrimeTest {

    function test_two() public {
        uint[] memory expected = new uint[](1);
        expected[0] = 2;
        assertTrue(arrays_are_equal(prime.generate(2), expected));
    }

    function test_three() public {
        uint[] memory expected = new uint[](1);
        expected[0] = 3;
        assertTrue(arrays_are_equal(prime.generate(3), expected));
    }

    function test_four() public {
        uint[] memory expected = new uint[](2);
        expected[0] = 2;
        expected[1] = 2;
        assertTrue(arrays_are_equal(prime.generate(4), expected));
    }

    function test_six() public {
        uint[] memory expected = new uint[](2);
        expected[0] = 2;
        expected[1] = 3;
        assertTrue(arrays_are_equal(prime.generate(6), expected));
    }

    function test_eight() public {
        uint[] memory expected = new uint[](3);
        expected[0] = 2;
        expected[1] = 2;
        expected[2] = 2;
        assertTrue(arrays_are_equal(prime.generate(8), expected));
    }

    function test_nine() public {
        uint[] memory expected = new uint[](2);
        expected[0] = 3;
        expected[1] = 3;
        assertTrue(arrays_are_equal(prime.generate(9), expected));
    }
    
    function arrays_are_equal(uint[] memory array1, uint[] memory array2) private pure returns (bool) {
        for (uint256 index = 0; index < array2.length; index++) {
            if (array2[index] != array1[index]) {
                return false;
            }
        }
        return true;
    }
}