class Api::V1::UsersController < ApplicationController
    skip_before_action :authorized, only: [:create]
 
    def profile
      options = {
        include: [:budgets, :transactions]
      }
      render json: { user: UserSerializer.new(current_user, options) }, status: :accepted
    end
   
    def create
      @user = User.create(user_params)
      if @user.valid?
        @user.buildBudgets
        @token = encode_token({ user_id: @user.id })
        render json: { user: UserSerializer.new(@user), jwt: @token, budgets: @user.budgets }, status: :created
      else
        render json: { error: 'failed to create user' }, status: :not_acceptable
      end
    end
 
  private
 
  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name, :income, :age)
  end
end
