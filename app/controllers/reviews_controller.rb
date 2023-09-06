class ReviewsController < PrivateController
	include ReviewsHelper
	# load_and_authorize_resource
	
	def index
		@reviews = Review.all
		render json: @reviews
	end

	def create
		@review = User.new(review_params)
		render_success_or_error_message(@review)
	end

	def show
		@review = User.find_by(id: params[:id])
		render json: @review
	end

	def update
		@review = User.find_by(id: params[:id])
		@review.update(review_params)
		render json: @review
	end

	def destroy
		User.find_by(id: params[:id]).destroy
		render json: 'review removed successfully!'
	end

	private

	def review_params
		params.permit(:description)
	end
end