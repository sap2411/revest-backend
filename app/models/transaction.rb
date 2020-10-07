require_relative './plaid.rb'
require 'plaid'
require 'date'

class Transaction < ApplicationRecord
  belongs_to :budget
  validates :plaid_id, uniqueness: true

  MAX_DAYS = 31

  def self.fetch_and_build(user)
    # grab either the oldest transaction or 31 days ago
    last = (!!user.transactions.first ? user.transactions.first.date : (Date.today - MAX_DAYS))
    if user.transactions.length > 0
      # destroy all transactions that are over a month ago
      destroy_old_transactions(user)
    end
    # grab transactions from bank
    Plaid.fetch(user.access_token, start_date = Date.today, last_date = last).map do |transaction|
      save_transaction(transaction)
    end
  end 

  def self.destroy_old_transactions(user)
    tran = user.transactions.each{|tran| 
      if tran.date < 32.days.ago
        tran.destroy
      end
    }
    user
  end

  def self.save_transaction(transaction)
    # ignore primary income transactions
    if transaction['category'].include? "Payroll"
      "nil"
    else
    matchingCat = []
    transaction['category'].each {|tranCat| 
        # check for budgets that the transaction could belong to
        result = user.budgets.find {|budget|
          budget.category[:tags].include? tranCat
        }
        if result != nil
          matchingCat << [result, tranCat]
        end
    }
    merchant = (!!transaction['merchant_name'] ? transaction['merchant_name'] : "No-Name")
    # handle different errors to assign the transaction to a proper budget
    if matchingCat.empty?
      !!transaction['merchant_name'] ? transaction_type = transaction['merchant_name'] : transaction_type = transaction['category'][0]
      budget_id = user.budgets.last.id
    elsif ('Uber Eats Grubhub Postmates DoorDash'.include? merchant) && matchingCat.last[1] != "Taxi"
      transaction_type = "Food and Drink"
      budget_id = user.budgets[1].id
    elsif matchingCat.last[1] == 'shops'
      transaction_type = transaction['merchant_name']
      budget_id = matchingCat.last[0].id
    else
      transaction_type = matchingCat.last[1]
      budget_id = matchingCat.last[0].id
    end
    # transaction now has matchingCat, an array of matching budgets. create the transaction for the database
    tran = {amount: transaction['amount'], name: transaction['name'], iso_currency_code: transaction['iso_currency_code'], date: Date.parse(transaction['date']), account_id: transaction['account_id'], cat_num: transaction['category_id'], transaction_type: transaction_type, budget_id: budget_id, plaid_id: transaction['transaction_id']}
    initialized_transaction = self.create(tran)
    initialized_transaction
    end
  end
end
