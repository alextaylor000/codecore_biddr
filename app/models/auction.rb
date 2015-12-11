class Auction < ActiveRecord::Base
  include AASM
  AUCTION_OPENING_PRICE = 1

  has_many :bids

  validates :title, :details, :ends_on, :reserve_price, presence: true
  validates :title, uniqueness: true

  before_create do
    self.current_price = AUCTION_OPENING_PRICE
  end

  aasm whiny_transitions: false do
    state :published, initial: true
    state :reserve_met
    state :won
    state :cancelled
    state :reserve_not_met

    event :add_bid_lower_than_reserve do
      before do
        calculate_current_price
      end
      transitions from: :published, to: :reserve_not_met
    end

    event :add_bid_higher_than_reserve do
      before do
        calculate_current_price
      end
      transitions from: [:published, :reserve_not_met], to: :reserve_met
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

  def calculate_current_price
    highest_bid = bids.order("amount DESC").first
    this_bid    = bids.order("created_at DESC").first

    if highest_bid == this_bid
      self.current_price += 1
    elsif (this_bid.amount > highest_bid.amount)
      self.current_price += (highest_bid.amount + 1)
    else
      self.current_price = this_bid.amount + 1
    end
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

end
