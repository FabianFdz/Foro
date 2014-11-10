require 'sinatra'
require "./Logica.rb"
require 'json'

Usuario.cargar_txt

get '/' do
	"Foro FdzCM!"
end

####################Modulo de Registro y Login###############################

get '/registrar/:name' do #recibe usuario-contrasenna. Ejm: fdz-123
	res = {}
  	res = Usuario.registra_user(params[:name])
  	"#{res} para #{params[:name]}! (User-Pass)"
end

get '/existe/:name' do #recibe usuario. Ejm: fdz
  	# if Usuario.user_existe(params[:name]) == true
  	# 	return "Usuario si existe!"
  	# end
  	# if Usuario.user_existe(params[:name]) == false
  	# 	return "Usuario no existe!"
  	# end
  	return "#{Usuario.user_existe(params[:name])}"
end

get '/login/:user_pass' do #recibe usuario-contrasenna. Ejm: fdz-123
  	return "#{Usuario.LogUser(params[:user_pass])}"
end

get '/users' do
	response = {}
	while condition
		response[:user] = 
	end
	return "#{$users_registrados}"
end

##############################################################################

get '/C-pregunta/:user_preg' do
	"#{Pregunta.crearPregunta(params[:user_preg])}"
end



## Implementar para registrar (/usuario-contrasenna) 
## => Debe verificar que el usuario no exista
## => Insertar en *.txt
# Implementar log in de usuarios
# => Verificar que tenga la contrasenna correcta mientras verifica que existe el usuario
# Preguntas:
# Para asociar preguntas con el usuario (/usuario-pregunta)
# Cada pregunta tiene un *.txt
# => La primer linea va a ser la pregunta y va a estar con el formato usuario;,pregunta;,etiquetas
# => El resto de lineas son respuestas y tienen el formato usuario;,respuesta
# Respuestas:
# Para que una pregunta reciba una respuesta se recibe lo siguiente usuario_pregunta-pregunta-usuario_responde-respuesta
# Cada respuesta se almacena al final del documento
# Cuando se va a devolver de la mas reciente a la mas antigua se saca de abajo para arriba (Se lee normal pero se le da vuelta a la lista)