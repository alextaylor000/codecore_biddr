class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.references :auction, index: true, foreign_key: true
      t.money :amount

      t.timestamps null: false
    end
  end
end
