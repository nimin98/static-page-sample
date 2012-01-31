class UsersController < ApplicationController

  def show
    # communication to the model side
    @user  = User.find(params[:id])

    # communication to the view side
    @title = @user.name
  end

  def new
    # communication to the model side

    # communication to the view side
    @title = "Sign up"
  end

end
