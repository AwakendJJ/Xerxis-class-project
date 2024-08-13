// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EventRSVP {
    address public organizer;
    string public eventName;
    uint public eventDate;

    struct Attendee {
        address attendeeAddress;
        bool hasRSVPed;
    }

    mapping(address => Attendee) public attendees;
    uint public totalRSVPs;

    event RSVP(address indexed attendee);

    constructor(string memory _eventName, uint _eventDate) {
        organizer = msg.sender;
        eventName = _eventName;
        eventDate = _eventDate;
        totalRSVPs = 0;
    }

    function rsvp() public {
        require(block.timestamp < eventDate, "Event has already occurred");

        Attendee storage attendee = attendees[msg.sender];
        require(!attendee.hasRSVPed, "Already RSVPed");

        attendee.attendeeAddress = msg.sender;
        attendee.hasRSVPed = true;
        totalRSVPs++;
        emit RSVP(msg.sender);
    }

    function getAttendee(address _attendee) public view returns (bool) {
        return attendees[_attendee].hasRSVPed;
    }
}
