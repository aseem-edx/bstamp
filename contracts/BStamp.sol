// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts-upgradeable/security/PausableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract BSTAMP is Initializable, PausableUpgradeable, OwnableUpgradeable {
    struct Bstamp {
        string stampUri;
        string appName;
        uint256 index;
    }

    string[] private stampIndex;
    mapping(string => Bstamp) private bstamp;

    event LogNewStamp(string stampUri, string id, string appName);

    function initialize() public initializer {
        __Pausable_init();
        __Ownable_init();
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function isStamp(string memory id) public view returns (bool) {
        if (stampIndex.length == 0) return false;
        return (keccak256(abi.encodePacked(stampIndex[bstamp[id].index])) ==
            keccak256(abi.encodePacked(id)));
    }

    function stamp(
        string memory id,
        string memory stampUri,
        string memory appName
    )
        public
        whenNotPaused
        returns (string memory, string memory, string memory)
    {
        if (isStamp(id)) revert("not allowed");

        stampIndex.push(id);
        bstamp[id].stampUri = stampUri;
        bstamp[id].appName = appName;
        bstamp[id].index = stampIndex.length - 1;
        emit LogNewStamp(stampUri, id, appName);

        return (stampUri, appName, id);
    }

    function getStamp(
        string memory id
    ) public view returns (string memory, string memory) {
        require(isStamp(id), "BSTAMP: stamp does not exist");
        return (bstamp[id].stampUri, bstamp[id].appName);
    }
}
