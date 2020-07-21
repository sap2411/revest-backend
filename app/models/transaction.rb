require_relative './plaid.rb'
require 'plaid'
require 'date'

class Transaction < ApplicationRecord
  belongs_to :budget

  def self.fetch_and_build(token, user)
    Plaid.fetch(token).map do |transaction|
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
      byebug
      if matchingCat.empty?
        matchingCat = [[user.budgets.last, "misc"]]
      end
      # transaction now has matchingCat, an array of matching budgets
      tran = {amount: transaction['amount'], name: transaction['name'], iso_currency_code: transaction['iso_currency_code'], date: Date.parse(transaction['date']), account_id: transaction['account_id'], cat_num: transaction['category_id'], transaction_type: matchingCat.last[1], budget_id: matchingCat.last[0].id}
      initialized_trcansaction = self.create(tran)
      initialized_transaction
    end
  end
end
