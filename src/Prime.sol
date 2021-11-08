// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract PrimeFactors {
    uint[] public array;

    function generate (uint number) public returns (uint[] memory) {
        for (uint candidate = 2; number > 1; candidate++) {
            for (; number % candidate == 0; number /= candidate) {
                array.push(candidate);
            }
        }
        return array;
    }
}