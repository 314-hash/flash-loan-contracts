// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@aave/core-v3/contracts/flashloan/base/FlashLoanSimpleReceiverBase.sol";
import "@aave/core-v3/contracts/interfaces/IPoolAddressesProvider.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract FlashLoanArbitrage is FlashLoanSimpleReceiverBase, Ownable {
    constructor(address _provider)
        FlashLoanSimpleReceiverBase(IPoolAddressesProvider(_provider))
        Ownable(msg.sender)
    {}

    function executeOperation(
        address asset,
        uint256 amount,
        uint256 premium,
        address initiator,
        bytes calldata params
    ) external override returns (bool) {
        // Your arbitrage logic goes here (DEX trades, etc.)

        // Repay loan + premium
        uint256 totalAmount = amount + premium;
        IERC20(asset).approve(address(POOL), totalAmount);

        return true;
    }

    function startFlashLoan(address token, uint256 amount) external onlyOwner {
        POOL.flashLoanSimple(address(this), token, amount, "", 0);
    }

    receive() external payable {}
}
