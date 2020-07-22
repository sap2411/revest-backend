require_relative './plaid.rb'
require 'plaid'
require 'date'

class Transaction < ApplicationRecord
  belongs_to :budget

  def self.fetch_and_build(token, user)
    Plaid.fetch(token).map do |transaction|
      if transaction['category'].include? "Payroll"
        "nil"
      else
      matchingCat = []
      correctTranCat = nil
      transaction['category'].each {|tranCat| 
          result = user.budgets.find {|budget|
            budget.category[:tags].include? tranCat
          }
          if result != nil
            matchingCat << [result, tranCat]
          end
      }
      merchant = (!!transaction['merchant_name'] ? transaction['merchant_name'] : "No-Name")
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
      # transaction now has matchingCat, an array of matching budgets
      tran = {amount: transaction['amount'], name: transaction['name'], iso_currency_code: transaction['iso_currency_code'], date: Date.parse(transaction['date']), account_id: transaction['account_id'], cat_num: transaction['category_id'], transaction_type: transaction_type, budget_id: budget_id}
      initialized_transaction = self.create(tran)
      initialized_transaction
      end
    end
  end
end
