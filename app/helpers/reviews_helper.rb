module ReviewsHelper
	def render_success_or_error_message(review)
		if review.save
			render json: 'review added successfully!'
		else
			render json: review.errors.full_messages
		end
	end 
end