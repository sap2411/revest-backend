class AddPlaidIdToTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :transactions, :plaid_id, :string
  end
end
