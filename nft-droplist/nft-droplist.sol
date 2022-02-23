// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract hunter{

    address owner;

    constructor(){
        owner = msg.sender;
    }

    modifier onlyOwner{
        require(msg.sender == owner,"you are not owner");
        _;
    }

    // define a stuct for data needed
    struct Drop {
        string imageUrl;
        string name;
        string description;
        string social_1;
        string social_2;
        string website;
        string price;
        uint256 supply;
        uint256 presale;
        uint256 sale;
        uint8 chain;
        bool approved;
    }

    // create list for objects
    Drop[] public drops;
    mapping (uint256 => address) public users;

    //function for add the drop object list
    function addDrop(Drop memory _drop) public {
        _drop.approved = false;
        drops.push(_drop);
        uint256 id = drops.length - 1;
        users[id] = msg.sender;
    }

    //function for add the drop object list
    function updateDrop(uint256 _index, Drop memory _drop) public {
        require(msg.sender == users[_index],"only owner of drop can update");
        _drop.approved = false;
        drops[_index] = _drop;
    }

    // get droplist
    function getDrops() public view returns(Drop[] memory) {
        return drops;
    }

    // aprove a drop
    function aproveDrops(uint256 _index) public onlyOwner{
        Drop storage drop = drops[_index];
        drop.approved = true;
    }

}


