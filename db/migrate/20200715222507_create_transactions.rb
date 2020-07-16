class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.float :amount
      t.datetime :date
      t.string :name
      t.string :iso_currency_code
      t.integer :account_id
      t.string :plaid_id
      t.belongs_to :category, null: true, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
