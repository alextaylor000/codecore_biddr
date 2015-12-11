require 'rails_helper'

RSpec.describe Bid, type: :model do
  context "validations" do
    def valid_attributes(new_attributes = {})
      {
        amount: 500
      }.merge(new_attributes)
    end

    it "requires an amount" do
      b = Bid.new(amount: nil)
      expect(b).to be_invalid
    end

    it "requires an auction" do
      b = Bid.new(valid_attributes)
      b.auction = nil
      expect(b).to be_invalid
    end

    it "requires that the amount be greater than the auction's current price" do
      a = FactoryGirl.create(:auction)
      b = Bid.new( auction: a, amount: (a.current_price - 1) )
      expect(b).to be_invalid
    end
  end
end
