// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract MasterChannelLedger is Initializable, OwnableUpgradeable {
    struct MasterChannelRecord {
        string data;
        uint256 timestamp;
    }

    MasterChannelRecord[] public ledger;
    mapping(string => MasterChannelRecord) public MasterChannelDataToRecord;

    function initialize() public initializer {
        __Ownable_init();
    }

    function addMasterChannelRecord(string memory _data) public onlyOwner {
        require(
            MasterChannelDataToRecord[_data].timestamp == 0,
            "Data already exists in the ledger"
        );

        MasterChannelRecord memory newRecord = MasterChannelRecord({
            data: _data,
            timestamp: block.timestamp
        });

        ledger.push(newRecord);
        MasterChannelDataToRecord[_data] = newRecord;
    }

    function getAllData()
        public
        view
        returns (string[] memory, uint256[] memory)
    {
        uint256 count = ledger.length;
        string[] memory data = new string[](count);
        uint256[] memory timestamps = new uint256[](count);

        for (uint256 i = 0; i < count; i++) {
            data[i] = ledger[i].data;
            timestamps[i] = ledger[i].timestamp;
        }

        return (data, timestamps);
    }

    function getTimestampForData(
        string memory _data
    ) public view returns (uint256) {
        require(
            MasterChannelDataToRecord[_data].timestamp != 0,
            "data not found in the ledger"
        );
        return MasterChannelDataToRecord[_data].timestamp;
    }
}
