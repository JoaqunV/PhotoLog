class CommentController < ApplicationController
	def view
		@comments= Comment.all
	end
end
