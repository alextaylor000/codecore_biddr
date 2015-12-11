class ChangeStateToAasmStateOnAuctions < ActiveRecord::Migration
  def change
    rename_column :auctions, :state, :aasm_state
  end
end
