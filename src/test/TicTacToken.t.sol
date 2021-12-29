// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./utils/TicTacTokenTest.sol";

contract TestTTT is TicTacTokenTest {
    uint256 internal constant EMPTY = 0;
    uint256 internal constant X = 1;
    uint256 internal constant O = 2;

    function test_has_empty_board() public {
        for (uint256 i=0; i<9; i++) {
            assertEq(ttt.board(i), 0);
        }
    }

    function test_get_board() public {
        uint256[9] memory expected = [
            EMPTY,
            EMPTY,
            EMPTY,
            EMPTY,
            EMPTY,
            EMPTY,
            EMPTY,
            EMPTY,
            EMPTY
        ];
        uint256[9] memory actual = ttt.getBoard();
        for (uint256 i=0; i<9; i++) {
            assertEq(actual[i], expected[i]);
        }
    }

    function test_can_mark_space_with_X() public {
        playerX.markSpace(0);
        assertEq(ttt.board(0), X);
    }

    function test_can_mark_space_with_O() public {
        playerX.markSpace(1);
        playerO.markSpace(0);
        assertEq(ttt.board(0), O);
    }

    function testFail_cannot_overwrite_marked_space() public {
        playerX.markSpace(0);
        playerO.markSpace(0);
    }

    function test_checks_for_horizontal_win() public {
        playerX.markSpace(0);
        playerO.markSpace(3);
        playerX.markSpace(1);
        playerO.markSpace(4);
        playerX.markSpace(2);
        assertEq(ttt.winner(), X);
    }

    function test_checks_for_horizontal_win_on_another_line() public {
        playerX.markSpace(3);
        playerO.markSpace(6);
        playerX.markSpace(4);
        playerO.markSpace(7);
        playerX.markSpace(5);
        assertEq(ttt.winner(), X);
    }

    function test_checks_for_vertical_win() public {
        playerX.markSpace(1);
        playerO.markSpace(0);
        playerX.markSpace(2);
        playerO.markSpace(3);
        playerX.markSpace(4);
        playerO.markSpace(6);
        assertEq(ttt.winner(), O);
    }

    function test_checks_for_diagonal_win() public {
        playerX.markSpace(0);
        playerO.markSpace(1);
        playerX.markSpace(4);
        playerO.markSpace(5);
        playerX.markSpace(8);
        assertEq(ttt.winner(), X);
    }

    function test_checks_for_antidiagonal_win() public {
        playerX.markSpace(1);
        playerO.markSpace(2);
        playerX.markSpace(3);
        playerO.markSpace(4);
        playerX.markSpace(5);
        playerO.markSpace(6);
        assertEq(ttt.winner(), O);
    }

    function test_returns_zero_on_no_winner() public {
        playerX.markSpace(1);
        playerO.markSpace(4);
        assertEq(ttt.winner(), 0);
    }

    function test_returns_zero_on_empty_board() public {
        assertEq(ttt.winner(), 0);
    }

    function testFail_checks_valid_space() public {
        playerX.markSpace(10);
    }

    function test_tracks_current_turn() public {
        assertEq(ttt.currentTurn(), X);
        playerX.markSpace(1);
        assertEq(ttt.currentTurn(), O);
        playerO.markSpace(2);
        assertEq(ttt.currentTurn(), X);
    }

    function testFail_cannot_mark_same_symbol_twice() public {
        assertEq(ttt.currentTurn(), X);
        playerX.markSpace(1);
        playerX.markSpace(2);
    }

    function testFail_non_admin_cannot_reset_board() public {
        playerX.reset();
    }

    function test_board_can_be_reset() public {
        playerX.markSpace(1);
        playerO.markSpace(2);
        admin.reset();
        uint256[9] memory actual = ttt.getBoard();
        for (uint256 i=0; i<9; i++) {
            assertEq(actual[i], 0);
        }
    }

    function test_stores_playerX_address() public {
        assertEq(ttt.playerX(), address(playerX));
    }

    function test_stores_playerO_address() public {
        assertEq(ttt.playerO(), address(playerO));
    }

    function testFail_non_player_cannot_mark_board() public {
        other.markSpace(1);
    }

    function test_playerX_starts_with_zero_wins() public {
        assertEq(ttt.totalWins(address(playerX)), 0);
    }

    function test_playerO_starts_with_zero_wins() public {
        assertEq(ttt.totalWins(address(playerO)), 0);
    }

    function test_increments_win_count_on_win() public {
        playGameXWins();
        assertEq(ttt.totalWins(address(playerX)), 1);
    }

    function test_total_games_starts_at_0() public {
        assertEq(ttt.totalGames(), 0);
    }

    function test_total_games_increments_after_a_game() public {
        playGameXWins();
        assertEq(ttt.totalGames(), 1);
    }

}
