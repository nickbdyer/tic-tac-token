// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract TicTacToken {
    uint256[9] public board;
    
    uint256 internal turns;
    uint256 internal constant X = 1;
    uint256 internal constant O = 2; 
    uint256 internal constant EMPTY = 0;

    address public lastMsgSender;
    address public admin;
    address public playerX;
    address public playerO;

    constructor (address _admin, address _playerX, address _playerO) {
        admin = _admin;
        playerX = _playerX;
        playerO = _playerO;
    }

    function getBoard() public view returns (uint256[9] memory) {
        return board;
    }

    function reset() public {
        require(msg.sender == admin, "Must be admin");
        delete board;
    }

    function markSpace(uint256 space) public {
        uint256 symbol = _getSymbol(msg.sender);
        require(_validPlayer(msg.sender), "Unauthorized");
        require(_validTurn(symbol), "Not your turn");
        require(_validSpace(space), "Invalid space");
        require(_validSymbol(symbol), "Invalid symbol");
        require(_emptySpace(space), "Already marked");
        turns++;
        board[space] = symbol;
    }

    function _getSymbol(address caller) internal view returns (uint256) {
        if (caller == playerX) return X;
        if (caller == playerO) return O;
        return EMPTY;
    }

    function _validPlayer(address caller) internal view returns (bool) {
        return caller == playerX || caller == playerO;
    }

    function msgSender() public returns (address) {
        lastMsgSender = msg.sender;
        return lastMsgSender;
    }

    function _validTurn(uint256 symbol) internal view returns (bool) {
        return currentTurn() == symbol;
    }

    function _validSpace(uint256 i) internal pure returns (bool) {
        return i < 9;
    }

    function _emptySpace(uint256 i) internal view returns (bool) {
        return board[i] == 0;
    }

    function _validSymbol(uint256 symbol) internal pure returns (bool) {
        return symbol == X || symbol == O;
    }

    function currentTurn() public view returns (uint256) {
        return (turns % 2 == 0) ? X : O;
    }

    function winner() public view returns (uint256) {
        return _checkWins();
    }

    function _checkWins() internal view returns (uint256) {
        uint256[8] memory wins = [
            _row(0),
            _row(1),
            _row(2),
            _col(0),
            _col(1),
            _col(2),
            _diag(),
            _antiDiag()
        ];
        for (uint256 i = 0; i < wins.length; i++) {
            if (wins[i] == 1) {
                return X;
            } else if (wins[i] == 8) {
                return O;
            }
        }
        return 0;
    }

    function _row(uint256 row) internal view returns (uint256) {
        require(row <= 2, "Invalid row");
        return board[row] * board[row + 1] * board[row + 2];
    }

    function _col(uint256 col) internal view returns (uint256) {
        require(col <= 2, "Invalid col");
        return board[col] * board[col + 3] * board[col + 6];
    }

    function _diag() internal view returns (uint256) {
        return board[0] * board[4] * board[8];
    }

    function _antiDiag() internal view returns (uint256) {
        return board[2] * board[4] * board[6];
    }
}