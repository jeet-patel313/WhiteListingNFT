//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WhiteListNFT {
    // stores the maximum number of whitelisted address
    uint256 public maxNumberOfWhiteListAddress;

    // tracking the number of whitelisted address
    uint256 public numberOfAddressWhiteListed;

    // the owner of the contract
    address owner;

    // tracking all the whitelisted address
    mapping(address => bool) whiteListedAddresses;

    constructor(uint256 _maxWhiteListedAddresses) {
        owner = msg.sender;
        maxNumberOfWhiteListAddress = _maxWhiteListedAddresses;
    }

    // owner modifier
    modifier onlyOwner() {
        require(msg.sender == owner, "Error: Caller is not owner");
        _;
    }

    function addUserToWhiteList(address _addressToWhiteList) public onlyOwner {
        // checking if address is already a whitelisted address or not
        require(
            !whiteListedAddresses[_addressToWhiteList],
            "Address is already whitelisted"
        );

        // checking if reached maximum whitelisteduser capacity
        require(
            numberOfAddressWhiteListed <= maxNumberOfWhiteListAddress,
            "Error: Whitelist capacity exceeded"
        );
        whiteListedAddresses[_addressToWhiteList] = true;

        numberOfAddressWhiteListed += 1;
    }

    // verify if the user is whitelisted
    function verifyUserAddress(address _whitelistedAddress)
        public
        view
        returns (bool)
    {
        return whiteListedAddresses[_whitelistedAddress];
    }

    // removing user from whitelisting
    function removeUserAddressFromWhiteList(address _addressToRemove)
        public
        onlyOwner
    {
        require(
            whiteListedAddresses[_addressToRemove],
            "Error: Sender is not whitelisted"
        );

        whiteListedAddresses[_addressToRemove] = false;

        numberOfAddressWhiteListed -= 1;
    }

    // get total number of whitelisted address
    function getNumberOfWhiteListedAddress() public view returns (uint256) {
        return numberOfAddressWhiteListed;
    }

    // get maximum number of white listed address
    function getMaxNumberOfWhiteListedAddress() public view returns (uint256) {
        return maxNumberOfWhiteListAddress;
    }

    // get the owner of the product
    function getOwner() public view returns (address) {
        return owner;
    }
}
