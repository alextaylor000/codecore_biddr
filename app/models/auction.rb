class Auction < ActiveRecord::Base
  include AASM
  AUCTION_OPENING_PRICE = 1

  # handy trick from http://stackoverflow.com/a/19857120/2100285
  # returns only the persisted bids, used for calculating the
  # current price from existing bids. it was failing before this
  # because of the newly-instantiated @bid object for auction#show.
  has_many :bids do
    def persisted
      collect{ |bid| bid if bid.persisted? }
    end
  end

  validates :title, :details, :ends_on, :reserve_price, presence: true
  validates :title, uniqueness: true

  aasm whiny_transitions: false do
    state :published, initial: true
    state :reserve_met
    state :won
    state :cancelled
    state :reserve_not_met

    event :reserve_has_been_met do
      transitions from: :published, to: :reserve_met
    end
  end

  def pretty_date
    ends_on.strftime("%A, %B %e at %m:%S %p")
  end

  def num_bids
    bids.count
  end


  def display_status
    case aasm_state
    when "published"
      "No bids. Get on this!"
    when "reserve_met"
      "Reserve met"
    when "won"
      "Auction won"
    when "cancelled"
      "Auction cancelled by owner"
    when "reserve_not_met"
      "Reserve not met"
    end
  end

  # sets the current price of the auction based on the highest bid.
  def current_price
    bids.persisted.any? ? bids.persisted.order("amount DESC").first.amount : AUCTION_OPENING_PRICE
  end

end
