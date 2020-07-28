require_relative '../../../models/transaction.rb'
class Api::V1::PlaidController < ApplicationController
    include Plaid
  
    def plaidlogin 
      token = params[:token]
      @access_token = Plaid.generate_access_token(token)
  
      if @access_token
        current_user.update({access_token: @access_token, has_connection: true})
        render json: {
          access_token: @access_token
        }
      else
        render json: {
          status: 500,
          errors: ['Missing Access Token']
        }
      end
    end
  
    def getTransactions
      @transactions = Transaction.fetch_and_build((current_user.access_token), current_user)
      if @transactions
        render json: { user: UserSerializer.new(current_user)}, status: :created
      else 
        render json: {
          status: 500,
          errors: ['No Transaction Data Found']
        }
      end
    end
  
  end 