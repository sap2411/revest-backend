class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :email, :first_name, :last_name, :income, :age
  has_many :budgets
  has_many :transactions, through: :budgets
end
