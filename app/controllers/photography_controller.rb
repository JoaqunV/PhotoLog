class PhotographyController < ApplicationController
	def index
	 	@photo = Photography.all.where("id_usuario = #{session[:current_user_id]}").order("hora_subida DESC, fecha_subida DESC").limit(6);
	 	@phot = Photography.all.where("id_usuario = #{session[:current_user_id]}").order("hora_subida DESC, fecha_subida DESC").limit(1);
	 	@amigos = Amistad.all.where("id_usuario = #{session[:current_user_id]}");
	end
	def best
		@photo = Photography.all.order("promedio_valoracion DESC").limit(20);
	end
end
