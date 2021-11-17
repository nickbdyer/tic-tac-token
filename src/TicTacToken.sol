// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract TicTacToken {
    string[9] public board;

    function getBoard() public view returns (string[9] memory) {
        return board;
    }

    function markSpace(uint256 space, string calldata symbol) public {
        require(_validSymbol(symbol), "Invalid symbol");
        require(_emptySpace(space), "Already marked");
        board[space] = symbol;
    }

    function _emptySpace(uint256 i) internal view returns (bool) {
        return _compareString(board[i], "");
    }

    function _validSymbol(string memory symbol) internal pure returns (bool) {
        return _compareString(symbol, "X") || _compareString(symbol, "O");
    }

    function _compareString(string memory a, string memory b) internal pure returns (bool) {
        return keccak256(abi.encodePacked(a)) == keccak256(abi.encodePacked(b));
    }
}