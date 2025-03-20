// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract QuoteCollector {
    struct Quote {
        string text;
        string author;
        address addedBy;
        uint256 timestamp;
    }

    Quote[] public quotes;
    mapping(address => uint256) public userQuoteCount;

    event QuoteAdded(string text, string author, address indexed addedBy, uint256 timestamp);

    function addQuote(string memory _text, string memory _author) public {
        require(bytes(_text).length > 0, "Quote text cannot be empty");
        require(bytes(_author).length > 0, "Author name cannot be empty");
        
        quotes.push(Quote({
            text: _text,
            author: _author,
            addedBy: msg.sender,
            timestamp: block.timestamp
        }));
        userQuoteCount[msg.sender]++;

        emit QuoteAdded(_text, _author, msg.sender, block.timestamp);
    }

    function getQuote(uint256 _index) public view returns (string memory, string memory, address, uint256) {
        require(_index < quotes.length, "Quote index out of bounds");
        Quote storage quote = quotes[_index];
        return (quote.text, quote.author, quote.addedBy, quote.timestamp);
    }

    function getTotalQuotes() public view returns (uint256) {
        return quotes.length;
    }
}
