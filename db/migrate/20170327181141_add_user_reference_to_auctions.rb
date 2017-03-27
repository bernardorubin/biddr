class AddUserReferenceToAuctions < ActiveRecord::Migration[5.0]
  def change
    add_reference :auctions, :user, foreign_key: true, index: true
  end
end
