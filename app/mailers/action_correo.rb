class ActionCorreo < ApplicationMailer
	def bloqueo_email(user)
	  @user = user
	  @url  = 'http://photolog.nz'
	  mail(to: @user.correo, subject: 'Bloqueo en PhotoLog')
	end
end
