require_relative '../../../models/transaction.rb'
class Api::V1::PlaidController < ApplicationController
    include Plaid
  
    def plaidlogin 
      token = params[:token]
      # exchange public token for access token
      @access_token = Plaid.generate_access_token(token)
  
      if @access_token
        # save access token to user so they do not have to re-login to their bank
        current_user.update({access_token: @access_token, has_connection: true})
        # never show the token client side
        render json: {
          access_token: "Created"
        }
      else
        render json: {
          status: 500,
          errors: ['Missing Access Token']
        }
      end
    end
  
    def getTransactions
      @transactions = Transaction.fetch_and_build(current_user)
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