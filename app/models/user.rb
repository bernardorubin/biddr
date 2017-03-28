class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

     has_many :bookmarks, dependent: :destroy
     has_many :bookmarkeded_auctions, through: :bookmarks, source: :auction

  def display_name
    first_name.present? ? "#{first_name} #{last_name}" : email
  end
end
