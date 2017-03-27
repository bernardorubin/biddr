class BidsController < ApplicationController

  def create
    bids_params    = params.require(:bid).permit(:bid)
    @bid          = Bid.new bids_params
    @auction         = Auction.find params[:auction_id]
    @bid.auction   = @auction
    @bid.user = current_user
    @username = User.find @auction.user_id
    if @bid.save
      redirect_to auction_path(@auction), notice: 'Bid created!'
    else
      logger.debug "Bid failed Validations".yellow
      logger.debug " - #{@bid.errors.full_messages.join("\n - ")} The Bid was not saved".yellow
      flash[:alert] = 'please fix errors'
      render 'auctions/show'
    end
  end

  def destroy
    bid = Bid.find params[:id]
    bid.destroy
    redirect_to product_path(bid.auction_id), notice: 'Bid deleted!'
  end
end
