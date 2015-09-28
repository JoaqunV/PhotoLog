class PhotographyController < ApplicationController
	def index
	 	@photo = Photography.all.where("id_usuario = #{session[:current_user_id]}").order("fecha_subida DESC, hora_subida DESC").limit(6);
	 	@phot = Photography.all.where("id_usuario = #{session[:current_user_id]}").order("fecha_subida DESC, hora_subida DESC").limit(1);
	 	@amigos = Amistad.all.where("id_usuario = #{session[:current_user_id]}");
	end
	def best
		@photo = Photography.all.order("promedio_valoracion DESC").limit(20);
	end
	def new
		@formato_erroneo = false;
	   	if request.post?
	       	#Archivo subido por el usuario.
	      	archivo = params[:archivo];
	      	id_usuario = session[:current_user_id];
	      	titulo_foto = params[:titulo];
	      	descripcion_foto = params[:descripcion];
	      	#Nombre original del archivo.
	      	nombre = archivo.original_filename;
	      	#Directorio donde se va a guardar.
	      	directorio = "app/assets/images/fotos";
	      	#Extensión del archivo.
	      	extension = nombre.slice(nombre.rindex("."), nombre.length).downcase;
	      	#Verifica que el archivo tenga una extensión correcta.
	      	@sql = "Call INS_FOTO(#{id_usuario},'#{titulo_foto}','#{descripcion_foto}')";
	      	ActiveRecord::Base.connection.execute(@sql)
	      	@foto = Photography.all.order("fecha_subida DESC, hora_subida DESC").limit(1);
	      	@foto.each do |ultimaFoto|
	      		@nameUF = ultimaFoto.id_fotografia.to_s;
	      	end
	      	nuevo_nombre = "#{@nameUF}.jpg";
	      	if extension == ".jpg" 
	         	#Ruta del archivo.
	         	path = File.join(directorio, nuevo_nombre);
	         	#Crear en el archivo en el directorio. Guardamos el resultado en una variable, será true si el archivo se ha guardado correctamente.
	         	resultado = File.open(path, "wb") { |f| f.write(archivo.read) };
	         	#Verifica si el archivo se subió correctamente.
	         	if resultado
	            	subir_archivo = "ok";
	         	else
	            	subir_archivo = "error";
	         	end
	         	#Redirige al controlador "archivos", a la acción "lista_archivos" y con la variable de tipo GET "subir_archivos" con el valor "ok" si se subió el archivo y "error" si no se pudo.
	         	redirect_to '/index';
	      	else
	         @formato_erroneo = true;
	      	end
	    end
	end
end
