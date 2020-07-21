class Budget < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :transactions
end
