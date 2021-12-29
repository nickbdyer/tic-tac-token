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

    mapping(address => uint256) public totalWins;
    uint256 public totalGames;

    constructor (address _admin, address _playerX, address _playerO) {
        admin = _admin;
        playerX = _playerX;
        playerO = _playerO;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Must be admin");
        _;
    }

    modifier onlyPlayer() {
        require(_validPlayer(msg.sender), "Unauthorised");
        _;
    }

    function getBoard() public view returns (uint256[9] memory) {
        return board;
    }

    function reset() public onlyAdmin {
        delete board;
    }

    function msgSender() public returns (address) {
        lastMsgSender = msg.sender;
        return lastMsgSender;
    }

    function markSpace(uint256 space) public onlyPlayer {
        require(_validTurn(msg.sender), "Not your turn");
        require(_validSpace(space), "Invalid space");
        turns++;
        board[space] = _getSymbol(msg.sender);
        if (winner() != 0) {
            totalGames++;
            address winnerAddress = _getAddress(winner());
            totalWins[winnerAddress]++;
        }
    }

    function _getAddress(uint256 symbol) internal view returns (address) {
        if (symbol == X) return playerX;
        if (symbol == O) return playerO;
        return address(0);
    }

    function _getSymbol(address caller) internal view returns (uint256) {
        if (caller == playerX) return X;
        if (caller == playerO) return O;
        return EMPTY;
    }

    function _validPlayer(address caller) internal view returns (bool) {
        return caller == playerX || caller == playerO;
    }

    function _validTurn(address player) internal view returns (bool) {
        return currentTurn() == _getSymbol(player);
    }

    function _validSpace(uint256 i) internal view returns (bool) {
        return i < 9 && board[i] == 0;
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
        require(row <= 6, "Invalid row");
        uint256 pos = row * 3;
        return board[pos] * board[pos + 1] * board[pos + 2];
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
