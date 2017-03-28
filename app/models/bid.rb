class Bid < ApplicationRecord
  belongs_to :auction
  belongs_to :user
  validates :bid, {presence: true}#, numericality: {greater_than_or_equal_to: }}
  validate :set_currentprice


  private


  def bid_not_lower_than_highest_bid

  end


  def set_currentprice
    a = Auction.find (self.auction)
    if bid.present? && bid <= a.currentprice
      errors.add(:bid, 'Bid Should be Higher than current Bid')
    end
  end

end
