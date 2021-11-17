// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./utils/TicTacTokenTest.sol";

contract TestTTT is TicTacTokenTest {

    function test_has_empty_board() public {
        for (uint256 i=0; i<9; i++) {
            assertEq(ttt.board(i), "");
        }
    }

    function test_get_board() public {
        string[9] memory expected = ["", "", "", "", "", "", "", "", ""];
        string[9] memory actual = ttt.getBoard();
        for (uint256 i=0; i<9; i++) {
            assertEq(actual[i], expected[i]);
        }
    }

    function test_can_mark_space_with_X() public {
        ttt.markSpace(0, "X");
        assertEq(ttt.board(0), "X");
    }

    function test_can_mark_space_with_O() public {
        ttt.markSpace(0, "O");
        assertEq(ttt.board(0), "O");
    }

    function testFail_cannot_mark_space_with_Z() public {
        ttt.markSpace(0, "Z");
    }

    function testFail_cannot_overwrite_marked_space() public {
        ttt.markSpace(0, "X");
        ttt.markSpace(0, "O");
    }

}