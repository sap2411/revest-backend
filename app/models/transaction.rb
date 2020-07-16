class Transaction < ApplicationRecord
  belongs_to :user_id
  belongs_to :budget_id
end
