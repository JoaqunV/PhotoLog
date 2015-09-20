class AdministradorController < ApplicationController
  def index
  	#@tareas = Tarea.select("id, titulo, descripcion").where(:activo => true).order("id DESC");
  	@auditorys= Auditory.all.order("id_auditoria DESC").limit(20);
  	@users= User.all
  end
  def gestion
  	@users= User.all
  end	
  def desbloquear
	@usuario = User.find(params[:format])
	@usuario.estado = 1;
	@usuario.save
	redirect_to administrador_url
  end
  def bloquear
	@usuario = User.find(params[:format])
	@usuario.estado = 0;
	@usuario.save
	ActionCorreo.bloqueo_email(@usuario).deliver
	redirect_to administrador_url
  end
end
