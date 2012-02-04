module SessionsHelper

  def sign_in(user)
    # save the cookie
    cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    # set the current user to the signed in user
    self.current_user = user
  end

  def sign_out
    # destroy the cookie
    cookies.delete(:remember_token)
    # reset the current user to nil
    self.current_user = nil
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= user_from_remember_token
  end

  def signed_in?
    !current_user.nil?
  end

  #######
  private

  def user_from_remember_token
    # authenticate_with_salt is a model class function
    # *variable is to pass the two-element array as one argument
    User.authenticate_with_salt(*remember_token)
  end

  def remember_token
    # :remember_token is the name of the cookie,
    # the name is used as a key to the cookie "hash"
    cookies.signed[:remember_token] || [nil, nil]
  end

end
