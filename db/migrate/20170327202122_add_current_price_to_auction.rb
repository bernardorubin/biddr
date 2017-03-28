class AddCurrentPriceToAuction < ActiveRecord::Migration[5.0]
  def change
    add_column :auctions, :currentprice, :float
  end
end
