class AddCurrentPriceToAuctions < ActiveRecord::Migration
  def change
    add_column :auctions, :current_price, :money
  end
end
