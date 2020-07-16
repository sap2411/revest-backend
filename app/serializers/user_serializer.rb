class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :email, :password, :first_name, :last_name, :income, :age
  has_many :transactions
end
