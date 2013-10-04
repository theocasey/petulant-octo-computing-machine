class SessionsController < ApplicationController 

	def create 
		# make a new user if the user doesn't exist 
		# save them to a session[:user_id]

		@provider = auth_hash[:provider]
		@provider_id = auth_hash[:uid]

		@users = User.where(provider: @provider, provider_id: @provider_id)

		if @users.size == 0
			# create a new user
			@user = User.new
			@user.provider = @provider
			@user.provider_id = @provider_id
			@user.name = auth_hash[:info][:name]
			@user.email = auth_hash[:info][:email]
			@user.image = auth_hash[:info][:image]
			@user.save

			session[:user_id] = @user.id
		else
			@user = @users.first
			session[:user_id] = @user.id
			# sign in as that first user
		end 

		flash[:success] = "Logged in"
		redirect_to root_path

	end 	


	def destroy
		# log out 
		session[:user_id] = nil 
		flash[:success] = "Logged out" 
		redirect_to root_path
	end 

	protected 
	def auth_hash
		request.env['omniauth.auth']
	end

end