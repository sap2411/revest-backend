class User < ApplicationRecord
    has_many :transactions
    has_many :budgets
    has_many :categories, through: :transactions
    has_many :categories, through: :budgets
    has_secure_password
    validates :email, uniqueness: { case_sensitive: false }
    validates :email, presence: true
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

    def name
        `#{self.first_name} #{self.last_name}`
    end
end
