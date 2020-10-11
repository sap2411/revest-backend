class TransactionSerializer
  include FastJsonapi::ObjectSerializer
  belongs_to :budget
  attributes :id, :amount, :date, :name, :budget_id, :account_id, :transaction_type
end
