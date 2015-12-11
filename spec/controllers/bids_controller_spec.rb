require 'rails_helper'

RSpec.describe BidsController, type: :controller do
 # TODO: TDD for creating a bid on an auction.
 describe "#create" do
   let(:auction) { FactoryGirl.create(:auction) }

   context "with valid params" do
     def valid_bid_params
       FactoryGirl.attributes_for(:bid)
     end

     it "creates a bid record in the database" do
       expect do
         post :create, { auction_id: auction.id, bid: valid_bid_params }
       end.to change { Bid.count }.by(1)
     end

     it "associates the bid with the auction" do
       post :create, { auction_id: auction.id, bid: valid_bid_params }
       expect(Bid.last.auction).to be_present
     end

     it "shows the auction page" do
       post :create, { auction_id: auction.id, bid: valid_bid_params }
       expect(response).to redirect_to auction_path(auction)
     end
   end

   context "with invalid params" do
     def bid_params(new_attributes = {})
       FactoryGirl.attributes_for(:bid).merge(new_attributes)
     end

     it "doesn't create a bid record in the database" do
       expect do
         post :create, { auction_id: auction.id, bid: bid_params(amount: nil) }
      end.to_not change { Bid.count }

     end

     it "shows the auction page" do
       post :create, { auction_id: auction.id, bid: bid_params(amount: nil) }
       expect(response).to render_template "auctions/show"
     end
   end


 end
end
