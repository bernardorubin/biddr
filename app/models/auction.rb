class Auction < ApplicationRecord
  belongs_to :user
  has_many :bids, -> { order(created_at: :desc) }, dependent: :destroy
end
