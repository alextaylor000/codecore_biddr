class AuctionsController < ApplicationController
  def new
    @auction = Auction.new
  end

  def create
    @auction = Auction.new(auction_params)
    if @auction.save
      redirect_to @auction, notice: "Your auction is live!"
    else
      render :new
    end
  end

  def index
    @auctions = Auction.all.order("ends_on DESC")
  end

  def show
    @auction = Auction.find(params[:id])
    @bid = Bid.new
  end

  private
  def auction_params
    params.require(:auction).permit([:title, :details, :ends_on, :reserve_price])
  end
end
