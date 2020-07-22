class User < ApplicationRecord
    has_many :budgets
    has_many :transactions, through: :budgets
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

    def buildBudgets
        budgets = self.calculate_budgets
        inc = 0;
        budgets.each do |budget|
            Budget.create(user_id: self.id, category_id: (inc+1), amount: budget)
            inc+=1
        end
    end

    def calculate_budgets
        Category.all.map {|cat|
            budget = (self.income * cat.percentage).round
            if budget < cat.min
                budget = cat.min
            elsif budget > cat.max
                budget = cat.max
            end
            budget
        }
    end
end
