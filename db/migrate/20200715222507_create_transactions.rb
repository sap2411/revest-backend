class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.float :amount
      t.datetime :date
      t.string :name
      t.string :iso_currency_code
      t.string :account_id
      t.string :cat_num
      t.string :transaction_type
      t.belongs_to :budget, null: false, foreign_key: true

      t.timestamps
    end
  end
end
