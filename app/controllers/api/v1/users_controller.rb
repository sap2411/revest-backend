class Api::V1::UsersController < ApplicationController
    skip_before_action :authorized, only: [:create]
 
    def profile
      

      render json: { user: UserSerializer.new(current_user) }, status: :accepted
    end
   
    def create
      @user = User.create(user_params)
      if @user.valid?
        @user.buildBudgets
        @token = encode_token({ user_id: @user.id })
        render json: { user: UserSerializer.new(@user), jwt: @token, budgets: @user.budgets }, status: :created
      else
        render json: { error: 'failed to create user:' }, status: :not_acceptable
      end
    end

    def update
      user = User.find(params[:id])
      user.update(user_params)
      if user.valid?
          render json: UserSerializer.new(user)
      else
          render json: {errors: user.errors.full_messages}
      end
    end

    def destroy
      user = User.find(params[:id])
      if user
          if user.transactions.length > 0
            user.transactions.each {|tran| tran.destroy}
          end
          user.budgets.each{|budget| budget.destroy}
          user.destroy
          render json: {deleted: UserSerializer.new(user)}    
      else
          render json: {errors: ["User not found"]}
      end    
    end

  private
 
  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name, :income, :age)
  end
end
