// SPDX-License-Identifier:MIT

pragma solidity ^0.8.20;

contract Threadapp{

    uint16 public MAX_THREAD=300;

    struct Thread {
        address author;
        string content;
        uint256 timestamp;
        uint likes;
        uint id;
    }

    mapping (address=>Thread[]) public threads;

    address public owner;

    event threadcreated(uint256 id, address author, string content, uint256 timestamp);
    
    event threadliked(address liker,address threadAuthor,uint256 threadid,uint256 newlikecount);

    event threadunliked(address unliker,address threadAuthor,uint256 threadid,uint256 newlikecount);

    constructor(){
        owner=msg.sender;
    }

    modifier onlyOwner(){
        require(msg.sender==owner,"Yo are not the owner");
        _;
    }

    function changeThreadLenght(uint16 newThreadlength) public{
        MAX_THREAD = newThreadlength;
    }

    
    function createThread(string memory _thread) public{

    require(bytes(_thread).length<=MAX_THREAD,"Thread of character is too long");

     Thread memory newThread = Thread({
        id:threads[msg.sender].length,
        author: msg.sender,
        content:_thread,
        timestamp: block.timestamp,
        likes: 0

     });

    threads[msg.sender].push(newThread);
     
    emit threadcreated(newThread.id, newThread.author,newThread.content,newThread.timestamp);

    }
    function likeThread(address author, uint256 id) external {
        require(threads[author][id].id==id,"THREAD DOES NOT EXIST");

        threads[author][id].likes++;

        emit threadliked(msg.sender,author,id,threads[author][id].likes);
    }

    function unlikethread(address author, uint256 id) external {
     
     require(threads[author][id].id==id,"THREAD DOES NOT EXIST");
     require(threads[author][id].likes>0,"THREAD HAS NO LIKES");

     threads[author][id].likes--;

     emit threadunliked(msg.sender,author,id,threads[author][id].likes);
    }

    function getthread(uint _i) public view returns(Thread memory)
    {
        return threads[msg.sender][_i];
    }

    function getAllthread(address _owner)public view returns(Thread[] memory){
        return threads[_owner];
    }
}