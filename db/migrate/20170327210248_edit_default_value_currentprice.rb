class EditDefaultValueCurrentprice < ActiveRecord::Migration[5.0]
  def change
    change_column :auctions, :currentprice, :float, :default => 1
  end
end
