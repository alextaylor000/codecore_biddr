class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.string :title
      t.text :details
      t.date :ends_on
      t.money :reserve_price
      t.string :state

      t.timestamps null: false
    end
  end
end
