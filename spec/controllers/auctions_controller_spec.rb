require 'rails_helper'

RSpec.describe AuctionsController, type: :controller do
 # TODO: TDD for the new / create actions for the auction.
 describe "#new" do
   before do
     get :new
   end

   it "renders the 'new' template" do
     expect(response).to render_template(:new)
   end

   it "instantiates a new Auction object" do
     expect(assigns(:auction)).to be_a_new(Auction)
   end
 end

 describe "#create" do
   describe "with valid params" do
     def valid_auction_params
       FactoryGirl.attributes_for(:auction)
     end

     it "creates a new auction in the database" do
       expect do
         post :create, { auction: valid_auction_params }
       end.to change { Auction.count }.by(1)
     end

     it "redirects to auction#show" do
       post :create, { auction: valid_auction_params }
       expect(response).to redirect_to(auction_path(Auction.last))
     end
   end

   describe "with invalid params" do
     def invalid_auction_params
       params = FactoryGirl.attributes_for(:auction)
       params[:title] = nil
       params
     end

     it "doesn't create a new auction in the database" do
       expect do
         post :create, { auction: invalid_auction_params }
       end.to_not change { Auction.count }

     end

     it "renders auction#new" do
       post :create, { auction: invalid_auction_params }
       expect(response).to render_template(:new)
     end

   end
 end
end
