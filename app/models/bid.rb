class Bid < ActiveRecord::Base
  belongs_to :auction

  validates :auction_id, presence: true
  validates :amount, presence: true
  validate :amount_must_be_greater_than_current_price

  def amount_must_be_greater_than_current_price
    if amount.present? &&
         auction.present? &&
         amount < auction.current_price
      errors.add(:amount, "must be greater than the auction's current price. C'mon, live a little!!")
    end
  end
end
