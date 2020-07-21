class BudgetSerializer
    include FastJsonapi::ObjectSerializer
    belongs_to :user
    has_many :transaction
    attributes :id, :amount
  end