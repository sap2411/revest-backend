class TransactionSerializer
  belongs_to :user
  include FastJsonapi::ObjectSerializer
  attributes :amount, :date, :name, :iso_currency_code, :category, :account_id, :plaid_id, :user_id
end
