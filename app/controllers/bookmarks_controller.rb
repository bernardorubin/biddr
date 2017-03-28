class BookmarksController < ApplicationController
  before_action :authenticate_user!
  before_action :find_bookmark, only: :destroy
  before_action :find_auction, only: :create

  def index
    @user = User.find(params[:user_id])
    if @user == current_user
      @bookmarks = @user.bookmarkeded_auctions
    else
      redirect_back fallback_location: auctions_path, alert: 'Seeing Other People\'s Bookmarks isn\'t allowed'
    end
  end

  def create
    bookmark = Bookmark.new(user: current_user, auction: @auction)
    # if cannot? :bookmark, @auction
    #   redirect_back fallback_location: auctions_path, alert:'Bookmarking your own Auction is not'
    # end
    if bookmark.save
      redirect_back fallback_location: auctions_path, notice: 'Auction bookmarked! 👍'
    else
      redirect_back fallback_location: auctions_path, alert: 'Couldn\'t bookmark auction 🤙'
    end
  end

  def destroy
    opts = nil
    @bookmark.destroy ? opts = {notice: 'Post Un-liked 👎'} : opts = {alert: @like.errors.full_messages.join(', ')}
    redirect_back fallback_location: posts_path, **opts
  end


  private

  def find_auction
    @auction ||= Auction.find(params[:auction_id])
  end
  
  def find_bookmark
    @bookmark ||= Bookmark.find(params[:id])
  end
end
