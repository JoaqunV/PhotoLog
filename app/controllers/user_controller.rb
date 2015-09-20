class UserController < ApplicationController
	def index 
		@users= User.all
	end
	def new
		@usuario = User.new
	end
end
