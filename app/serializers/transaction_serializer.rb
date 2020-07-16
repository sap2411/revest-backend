class TransactionSerializer
  belongs_to :user
  include FastJsonapi::ObjectSerializer
  attributes :id, :amount, :date, :name, :iso_currency_code, :category_id, :account_id, :plaid_id, :user_id
end
