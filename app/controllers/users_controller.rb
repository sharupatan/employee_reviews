class UsersController < ApplicationController
	def index
		render json: 'user details'
	end

	def create
		@user = User.new(user_params)
		if @user.save
			render json: 'user registered successfully!'
		else
			render json: @user.errors.full_messages
		end
	end

	private

	def user_params
		params.permit(:name,:email,:password)
	end
end