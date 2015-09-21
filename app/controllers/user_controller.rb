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
	    if user = User.find_by(params[:nombre_acceso], params[:password], '1')
	    	session[:current_user_id] = user.id_usuario
	      	session[:current_user_fondo] = user.color_fondo
	    	if user.estilo_letra != 'default'  	
	      		session[:current_user_letra] = 	user.estilo_letra 
	      	end	
	      	redirect_to users_url
	    else
	      redirect_to iniciarSesion
	    end
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
