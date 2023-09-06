require 'jwt'

module UsersHelper
  def authenticate_user
		begin
			user
		rescue
			render json: 'please login to access webpage! / you are un authenticated!'
		end
	end

	def hmac_secret
		'my$ecretK3y'
	end

	def generated_jwt_token(payload)
		JWT.encode payload, hmac_secret, 'HS256'
	end

	def current_user
		begin
			user
		rescue
			'please login to access webpage! / you are un authenticated!'
		end
	end

	def user
		token = request.headers['Authorization'].split(' ')[1]
		user = JWT.decode token, hmac_secret, true, { algorithm: 'HS256' }
		user[0]
	end

	def render_jwt_or_error_message(user)
		if user.nil?
			render json: 'invalid email!'
		else
			render_jwt_or_password_error(user)
		end
	end

	def render_jwt_or_password_error(user)
		is_same = user.password == params[:password]
		if is_same
			render json: generated_jwt_token(user.attributes)
		else
			render json: 'invalid password!'
		end
	end

	def render_success_or_error_message(user)
		if user.save
			render json: 'user registered successfully!'
		else
			render json: user.errors.full_messages
		end
	end
end
