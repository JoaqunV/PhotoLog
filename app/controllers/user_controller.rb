class UserController < ApplicationController
	def index 
		@users= User.all
	end
	def new
		@usuario = User.new
	end
	def create
		@usuario = User.new(usuarios_params)
		sql= "CALL INS_USUARIO('"<<@usuario.nombre_usuario.to_s<<"','"<<@usuario.apellido_paterno.to_s<<"','"<<@usuario.apellido_materno.to_s<<"','"<<@usuario.nombre_acceso.to_s<<"','"<<@usuario.password.to_s<<"','"<<@usuario.correo.to_s<<"','"<<@usuario.direccion.to_s<<"','"<<@usuario.fechanacimiento.to_s<<"','"<<params[:sexo].to_s<<"','127.0.0.1');"
		response = ActiveRecord::Base.connection.execute(sql)
		redirect_to users_url
	end	
	def iniciarSesion
	end	



	def entrar
		#if user = User.find_by(nombre_acceso: params[:nombre_acceso], password: params[:password], estado: '1');
	    #if user = User.find_by_nombre_acceso_and_password_and_estado([:session][:nombre_acceso], [:session][:password], '1' )
	    user = User.where("nombre_acceso='#{params[:session][:nombre_acceso]}' AND password='#{params[:session][:password]}' AND estado = 1")
	    if user.blank? == false 

	    	session[:current_user_id] = user[0].id_usuario
	      	session[:current_user_fondo] = user[0].color_fondo
	    	if user[0].estilo_letra != 'default'  	
	      		session[:current_user_letra] = 	user[0].estilo_letra 
	      	end	
	      	redirect_to users_url
	    else
	      redirect_to '/ingresar'
	    end
	end
	def configuracion
		@usuario = User.find(session[:current_user_id])
	end	

	def editar
		sql= "CALL UPD_USUARIO('"<<session[:current_user_id].to_s<<"','"<params[:usuario][:coreo].to_s<<"','"<<params[:usuario][:direccion].to_s<<"','"<<params[:usuario][:fechanacimiento].to_s<<"','"<<params[:usuario][:sexo].to_s<<"','"<<params[:usuario][:color_fondo].to_s<<"','"<<params[:usuario][:estilo_letra].to_s<<"');"
		response = ActiveRecord::Base.connection.execute(sql)
		redirect_to users_url
	end

	def salir
    @_current_user = session[:current_user_id] = nil
    redirect_to users_url
  	end

	private
	def usuarios_params
	  	params.require(:usuario).permit(:nombre_usuario,:apellido_paterno,:apellido_materno,:nombre_acceso,:password,:correo, :direccion,:fechanacimiento)
	end
end
