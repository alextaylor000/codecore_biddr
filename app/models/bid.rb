class Bid < ActiveRecord::Base
  belongs_to :auction

  # TODO validate that bid price must by higher than the current price. Set current price to highest bid.
end
