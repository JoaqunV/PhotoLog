class PhotographyController < ApplicationController
	def index
	 	photo = Photography.all..where("id_usuario = #{session[current_user_id]}").order("hora_subida DESC, fecha_subida DESC").limit(5);
	end
	def best
	@photo = Photography.all.order("promedio_valoracion DESC").limit(20);
	end
end
