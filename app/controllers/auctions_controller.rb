class AuctionsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_auction, only: [:show, :edit, :destroy, :update]

  def index
    @auctions = Auction.order(created_at: :desc)
    
  end

  def show
    @bid = Bid.new
    @username = User.find @auction.user_id
  end

  def new
    @auction = Auction.new
  end

  def create
    # render json:params
    @auction = Auction.new(auction_params)
    @auction.user = current_user
    if @auction.save
      flash[:notice] = 'Auction created successfully'
      redirect_to auction_path(@auction)
    else
      flash.now[:alert] = 'Please fix errors below'
      render :new
    end
  end

  private
  def auction_params
    params.require(:auction).permit(:title, :description, :endson, :reserveprice)
  end
  def find_auction
    @auction = Auction.find params[:id]
  end
end
