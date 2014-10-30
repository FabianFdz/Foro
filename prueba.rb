require 'sinatra'
require "./Logica.rb"

get '/' do
	#Usuario.cargar_txt
	"Foro FdzCM!"
end

get '/registrar/:name' do #recibe usuario-contrasenna. Ejm: fdz-123
  # matches "GET /hello/foo" and "GET /hello/bar"
  # params[:name] is 'foo' or 'bar'
  Usuario.registra_user(params[:name])
  "Registro exitoso para #{params[:name]}! (User-Pass)"
end

get '/existe/:name' do #recibe usuario-contrasenna. Ejm: fdz-123
  # matches "GET /hello/foo" and "GET /hello/bar"
  # params[:name] is 'foo' or 'bar'
  res = Usuario.user_existe(params[:name])
  "Usuario #{res} existe!"
end

# Investigar manejo de archivos .txt en Ruby
# Implementar para registrar (/usuario-contrasenna)
# => Debe verificar que el usuario no exista
# => Insertar en *.txt
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

