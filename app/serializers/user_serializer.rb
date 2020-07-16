class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :email, :password, :first_name, :last_name, :income, :age
  has_many :transactions
end
