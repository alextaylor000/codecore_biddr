class Auction < ActiveRecord::Base
  include AASM
  AUCTION_OPENING_PRICE = 1

  has_many :bids

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

  def bids_latest
    bids.order("created_at DESC")
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
    bids.present? ? bids.order("amount DESC").first.amount : AUCTION_OPENING_PRICE
  end

end
