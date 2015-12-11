class BidsController < ApplicationController
  def create
    @auction = Auction.find(params[:auction_id])
    @bid = Bid.new( params.require(:bid).permit([:amount]) )
    @bid.auction = @auction
    if @bid.save
      # switch up the state based on the bid amount
      if @bid.amount > @auction.reserve_price
        @auction.add_bid_higher_than_reserve
      else
        @auction.add_bid_lower_than_reserve
      end

      @auction.save

      redirect_to @bid.auction, notice: "Bid saved!"
    else
      render "auctions/show"
    end
  end
end
