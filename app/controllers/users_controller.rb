class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy

  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
#    @users = User.all
  end

  def show
    # communication to the model side
    @user  = User.find(params[:id])

    # communication to the view side
    @title = @user.name
  end

  def new
    redirect_to(current_user) unless !signed_in?

    # communication to the model side
    @user  = User.new
    # communication to the view side
    @title = "Sign up"
  end

  def create
    redirect_to(current_user) unless !signed_in?

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

  def edit
    # communication to the model side
    # @user = User.find(params[:id])   # omitted because it has been called in "correct_user"

    # communication to the view side
    @title = "Edit user"
  end

  def update
    # communication to the model side
    # @user = User.find(params[:id])   # omitted because it has been called in "correct_user"
    if @user.update_attributes(params[:user]) #update_attributes is a build-in func
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end

  def destroy
    delete_user = User.find(params[:id])
    if (delete_user != current_user) 
        User.find(params[:id]).destroy
        flash[:success] = "User destroyed."
        redirect_to users_path
    end
  end

  #######
  private
  #######

  def authenticate
    deny_access unless signed_in?
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
