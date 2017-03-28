class BidsController < ApplicationController
  before_action :authenticate_user!

  def create
    bids_params       = params.require(:bid).permit(:bid)
    @bid              = Bid.new bids_params
    @auction          = Auction.find params[:auction_id]
    @bid.auction      = @auction
    @bid.user         = current_user
    @username         = User.find @auction.user_id
    if @bid.bid >= @auction.reserveprice
      puts 'hello'
      @auction.metreserve!
    end
    if @bid.save
      @auction.currentprice = @bid.bid
      @auction.save
      redirect_to auction_path(@auction), notice: 'Bid created!'
    else
      flash[:alert] = 'Please fix errors'
      render 'auctions/show'
    end
  end

  def destroy
    bid = Bid.find params[:id]
    bid.destroy
    redirect_to product_path(bid.auction_id), notice: 'Bid deleted!'
  end
end
