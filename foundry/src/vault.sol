// SPDX-License-Identifier: AGPL-3.0
pragma solidity ^0.8.25;

import { Ownable } from "@openzeppelin/access/Ownable.sol";
import { ERC20 } from "@openzeppelin/token/ERC20/ERC20.sol";


// Only for one token ! Only one eth address for one tez address !
contract Vault is Ownable{

    error TezAddressAlreadyDefined();
    error tezAddressNotDefined();
    error InsufficientBalance();
    error NothintToUnlock();

    ERC20 public token;

    mapping(address => uint256) public balances;

    mapping(address => uint256) public lockedBalances;

    mapping(address => uint256) public RequestedBalances;

    mapping(address => string) public tezAddresses;

    event Deposit(address indexed user, uint256 amount);
    event Unlock(address indexed user, uint256 amount);
    event RequestUnlock(address indexed user, string tezAddress, uint256 amount);
    event Withdraw(address indexed user, uint256 amount);

    constructor(address _token) Ownable(msg.sender){
        token = ERC20(_token);
    }

    modifier hasTezAddress(address user) {
        require(bytes(tezAddresses[msg.sender]).length > 0, tezAddressNotDefined());
        _;
    }

    function setTezAddress(string memory tezAddress) external {
        require(bytes(tezAddresses[msg.sender]).length > 0, TezAddressAlreadyDefined());
        tezAddresses[msg.sender] = tezAddress;
    }

    function deposit(uint256 amount) external hasTezAddress(msg.sender) {

        require(token.balanceOf(msg.sender) >= amount, InsufficientBalance());

        token.transferFrom(msg.sender, address(this), amount);

        lockedBalances[msg.sender] += amount;

        emit Deposit(msg.sender, amount);
    }

    function requestUnlock(uint256 amount) external hasTezAddress(msg.sender){
        require(lockedBalances[msg.sender] >= amount, InsufficientBalance());
        lockedBalances[msg.sender] -= amount;
        RequestedBalances[msg.sender] += amount;
        emit RequestUnlock(msg.sender, tezAddresses[msg.sender], amount);
    }

    function unlock(address user) external onlyOwner hasTezAddress(user) {
        require(RequestedBalances[user] <= 0, NothintToUnlock());
        uint256 amount = RequestedBalances[user];
        RequestedBalances[user] = 0;
        balances[user] += amount;
    }

    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, InsufficientBalance());
        balances[msg.sender] -= amount;
        token.transfer(msg.sender, amount);
        emit Withdraw(msg.sender, amount);
    }

    function balanceOf(address user) external view returns (uint256) {
        return balances[user];
    }


    function lockedBalanceOf(address user) external view returns (uint256) {
        return lockedBalances[user];
    }

    function requestedBalanceOf(address user) external view returns (uint256) {
        return RequestedBalances[user];
    }

    function tezAddressOf(address user) external view returns (string memory) {
        return tezAddresses[user];
    }

}
