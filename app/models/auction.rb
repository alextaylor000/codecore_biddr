class Auction < ActiveRecord::Base
  include AASM

  has_many :bids
  validates :title, :details, :ends_on, :reserve_price, presence: true
  validates :title, uniqueness: true

  # TODO just enforce triggering going from published to reserve met for now.
  aasm whiny_transitions: false do
    state :published, initial: true
    state :reserve_met
    state :won
    state :cancelled
    state :reserve_not_met

    # next, define transition events
    # similar to states, you get methods to trigger transitions, like 'publish', 'close', etc
    event :publish do
      transitions from: :draft, to: :published
    end
  end

end
