class UsersController < ApplicationController

  def show
    # communication to the model side
    @user  = User.find(params[:id])

    # communication to the view side
    @title = @user.name
  end

  def new
    # communication to the model side
    @user  = User.new
    # communication to the view side
    @title = "Sign up"
  end

  def create
    # communication to the model side
    @user = User.new(params[:user])
    if @user.save
      # communication to the view side
      flash[:success] = "Welcome to the Sample App!"
      sign_in @user
      redirect_to user_path(@user)
    else 
      # communication to the view side
      @title = "Sign up"
      # reset password field
      @user.password = ""
      @user.password_confirmation = ""
      render 'new'
    end
  end

end
