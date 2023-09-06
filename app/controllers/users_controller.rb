class UsersController < PrivateController
	include UsersHelper
	# load_and_authorize_resource
	
	def index
		@users = User.all
		render json: @users
	end

	def create
		@user = User.new(user_params)
		render_success_or_error_message(@user)
	end

	def show
		@user = User.find_by(id: params[:id])
		render json: @user
	end

	def update
		@user = User.find_by(id: params[:id])
		@user.update(user_params)
		render json: @user
	end

	def destroy
		User.find_by(id: params[:id]).destroy
		render json: 'user removed successfully!'
	end

	private

	def user_params
		params.permit(:name, :email, :password, :role)
	end
end