// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;  

contract twitter{

    struct Tweet{       //struct to store information of tweet
        uint id;
        address author;
        string content;
        uint createdAt;
    }

    struct message{       //struct to store information of massage
        uint id;
        string content;
        address from;
        address to;
        uint createdAt;
    }

    mapping(uint=>Tweet)public Tweets;                     //to store tweets
    mapping (address=>uint[])public tweetsOf;                 //store all the tweets from specific address
    mapping(address=>message[])public conversations;                //all the messages from specific address
    mapping(address=>mapping(address=>bool))public operators;      //give access to handle account
    mapping(address=>address[])public following;                     //store all the followers f the address

    uint nextId;
    uint nextMessageId;


    //function for creating tweet 
    function createTweet(address _from,  string memory _content)internal{
        Tweets[nextId]=Tweet(nextId,_from,_content,block.timestamp);
        nextId++;
    }
    

    //function for sending message
    function sendMessage(address _from, address _to, string memory _content)internal{
        conversations[_from].push(message(nextId,_content,_from,_to,block.timestamp));
        nextMessageId++;
    }

    //only owner of the account can able to tweet
    function selfTweet(string memory _content)public{
        createTweet(msg.sender, _content);
    }

    //function for account handler can tweet
    function handleTweet(address _from,  string memory _content)public{
        createTweet(_from, _content);
    }

    //only owner can send message
    function selfMessage( address _to, string memory _content)public{
        sendMessage(msg.sender, _to, _content);
    }

    //function for account handler to send messege
    function handleMessage(address _from, address _to, string memory _content)public{
        sendMessage(_from, _to, _content);
    }

    
    function follow(address _addressFollow)public {
        following[msg.sender].push(_addressFollow);
    }
  
    //function to give acceess to account handler
    function allow(address _addressAllow)public{
        operators[msg.sender][_addressAllow]=true;
    }

 
     //function to remove access from the account handler 
    function disAllow(address _addressDisAllow)public{
        operators[msg.sender][_addressDisAllow]=false;
    }
      

    //function to get the latest tweets
    function getlatestTweets(uint _count)public returns(Tweet[]memory){
        Tweet[]memory _tweets=new Tweet[](_count);  

    uint j;

    for(uint i=nextId - _count; i<nextId ; nextId++){
        Tweet[]storage _structure= Tweets(i);   

        _tweets(j)=Tweet(_structure.id,_structure.author,_structure.content,_structure.createdAt);

        j++;

    }
    return _tweets; 



    }




}


  


