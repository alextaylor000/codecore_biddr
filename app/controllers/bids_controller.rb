class BidsController < ApplicationController
  def create
    @auction = Auction.find(params[:auction_id])
    @bid = Bid.new( params.require(:bid).permit([:amount]) )
    @bid.auction = @auction
    if @bid.save
      redirect_to @bid.auction, notice: "Bid saved!"
    else
      render "auctions/show"
    end
  end
end
