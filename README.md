# Thread-Decentralized
The onlyOwner modifier should be used in the changeThreadLength function to ensure only the owner can change it n also, making the owner variable immutable .since it’s set only once in the constructor. 
1.address public immutable owner;
2.function changeThreadLength(uint16 newThreadLength) public onlyOwner {}
