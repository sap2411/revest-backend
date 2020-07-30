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
    PASSWORD_FORMAT = /\A
    (?=.{6,})          # Must contain 6 or more characters
    (?=.*\d)           # Must contain a digit
    (?=.*[a-z])        # Must contain a lower case character
    (?=.*[A-Z])        # Must contain an upper case character
    (?=.*[[:^alnum:]]) # Must contain a symbol
    /x

    validates :password, 
    presence: true, 
    length: { in: 6..20 }, 
    format: { with: PASSWORD_FORMAT }, 
    on: :create 

    validates :password, 
    allow_nil: true, 
    length: { in: 6..20 }, 
    format: { with: PASSWORD_FORMAT }, 
    on: :update

    def buildBudgets
        budgets = self.calculate_budgets
        inc = 0;
        budgets.each do |budget|
            Budget.create(user_id: self.id, category_id: (inc+1), amount: budget)
            inc+=1
        end
    end

    def updateBudgets
        self.budgets.each {|budget|
            amount = (self.income * budget.category.percentage).round
            if amount < budget.category.min
                amount = budget.category.min
            elsif amount > budget.category.max
                amount = budget.category.max
            end
            budget.update({amount: amount})
        }
    end

    def calculate_budgets
        # calculate what each budget should be set to based off the users income, the percent of income that should go to a category, and a min and max amount
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
