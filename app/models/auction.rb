class Auction < ApplicationRecord
  belongs_to :user
  has_many :bids, -> { order(created_at: :desc) }, dependent: :destroy
  validates :title, {presence: true}
  validates :endson, {presence: true}
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarkers, through: :bookmarks, source: :user

  def bookmarked_by?(user)
    bookmarks.exists?(user: user)
  end

  def bookmark_for(user)
    bookmarks.find_by(user: user)
  end



    include AASM


  aasm whiny_transitions: false do
    state :draft, initial: true
    state :published, :reservemet, :won, :canceled, :reservenotmet

    event :publish do
      transitions from: :draft, to: :published
    end

    event :cancel do
      transitions from: [:published, :reservemet, :reservenotmet], to: :canceled
    end

    event :metreserve do
      transitions from: :draft, to: :reservemet
    end

    event :metreservenot do
      transitions from: :published, to: :reservenotmet
    end

    event :won do
      # transitions from: :published, to: :unfunded
    end

  end

end
