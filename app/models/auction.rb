class Auction < ApplicationRecord
  belongs_to :user
  has_many :bids, -> { order(created_at: :desc) }, dependent: :destroy
  validates :title, {presence: true}
  validates :endson, {presence: true}

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
      transitions from: :published, to: :reservemet
    end

    event :metreservenot do
      transitions from: :published, to: :reservenotmet
    end

    event :won do
      # transitions from: :published, to: :unfunded
    end

  end

end
