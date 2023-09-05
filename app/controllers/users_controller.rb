require 'jwt'

class UsersController < ApplicationController
	before_action :authenticate_user

	def index
		render json: 'user details'
	end

	def create
		@user = User.new(user_params)
		if @user.save
			render json: 'user registered successfully! please login to access the website.'
		else
			render json: @user.errors.full_messages
		end
	end

	def login
		@user = User.find_by(email: params[:email])
		if @user.nil?
			render json: 'invalid email!'
		else
			is_same = @user.password == params[:password]
			if is_same
				render json: generated_jwt_token(@user.attributes)
			else
				render json: 'invalid password!'
			end
		end
	end

	private

	def user_params
		params.permit(:name, :email, :password)
	end

	def hmac_secret
		'my$ecretK3y'
	end

	def generated_jwt_token(payload)
		JWT.encode payload, hmac_secret, 'HS256'
	end

	def authenticate_user
		token = request.headers['Authorization'].split(' ')[1]
		begin
			p JWT.decode token, hmac_secret, true, { algorithm: 'HS256' }
		rescue
			render json: 'please login to access webpage!'
		end
	end
end