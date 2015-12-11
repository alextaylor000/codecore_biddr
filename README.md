==BIDDR

Final exam for CodeCore Bootcamp, October 2015.

Implements:
* TDD for the new / create actions for the auction.
* TDD for creating a bid on an auction.
* A state machine with these states for the auction.: published / reserve met / won / canceled / reserve not met.
* Events to handle published -> reserve met, published -> reserve_not_met, reserve_not_met -> reserve_met.
* Validation that the bid price must be higher than the current price.
* $1 increments for the bidding process. For instance, if the current price is $10 and someone bids $15, the current price should become $11. Then if someone bids $13 it should become $14.
