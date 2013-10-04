class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # make sure we can use basket in the view as well as the controller
  helper_method :basket


  # because the basket is everywhere on the site 
  # (e.g. you want a basket on the products page or orders page)
  # we put it here
  def basket

  	# if the user doesn't have a basket
  	# give them an empty one
  	if session[:basket].nil?
  		# basket is an empty list
  		# using set because we don't want to add the same thing twice
  		session[:basket] = Set.new
  	end

  	# actually give them the basket
  	session[:basket]

  end

helper_method :current_user

def current_user
    if session[:user_id].present?
        User.find(session[:user_id])
      end

    end


end






