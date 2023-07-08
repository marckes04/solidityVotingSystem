// SPDX-License-Identifier: MIT

contract voteSystem {


    enum Candidates {
        donald,
        biden,
        klington,
        obama
    }
    uint256 timeStart;
    uint256 timeEnd;
    uint256 votingOptions;
    mapping(Candidates => uint) votingOptionsResult;
    mapping(address => bool) userVotedMap;

    event UserVote(address person);

    constructor(uint256 _timeStart, uint256 _timeEnd) {
        timeStart = _timeStart;
        timeEnd = _timeEnd;
        votingOptions = 4;
    }

    function getTimeStart() public view returns (uint) {
        return timeStart;
    }

    function getTimeEnd() public view returns (uint) {
        return timeEnd;
    }

    function hasAlreadyVoted(address add) public view returns (bool) {
        return userVotedMap[add];
    }

    function vote(Candidates candidate) public {
        require(userVotedMap[msg.sender] == false, "User already voted");
        require(
            block.timestamp > timeStart,
            "The voting time hasn not started "
        );
        require(block.timestamp < timeEnd, "The voting has already ended");

        userVotedMap[msg.sender] = true;
        votingOptionsResult[candidate] += 1;
        emit UserVote(msg.sender);
    }
}
