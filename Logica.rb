$users_registrados = [] #lista que contiene objetos tipo Usuario
$all_preguntas = [] #lista de preguntas de todos los usuarios
$ID = 0 #ID de preguntas

class Usuario#############################################################################################################
	def initialize(user,pass) # Constructor de Usuario
		@user = user # Usuario
		@pass = pass # Contrasenha
	end

	def getUser() # Obtiene User de objeto Usuario
		@user
	end

	def getPass() # Obtiene Pass de objeto Usuario
		@pass
	end

	def self.getUsuarios()
		$users_registrados
	end

	def self.cargar_txt() # => Carga los usuarios a memoria en caso de cierre de programa
		archivo = File.new("users.txt","a+") #Abre el archivo "users", si no existe lo crea
		archivo.rewind #Vamos a la primera linea del archivo
		lista_users = archivo.readlines #Lee todas las lineas y las mete a la variable en forma de lista
		cont = 0 #contador para recorrer lista
		while cont < lista_users.length
			temp = lista_users[cont].split(",")	#Los users y pass esta separados por "," (Comas) se crea una lista de esta forma [user,pass]
			$users_registrados[$users_registrados.length] = Usuario.new(temp[0],temp[1].chomp) #Agrega a final de lista a objeto tipo Usuario 
			cont = cont + 1 #Aumenta contador
		end
		archivo.close # Cierra archivo y guarda los cambios
	end

	def self.registra_user(texto) # => Agrega el usuario al txt y a la lista de users_registrados. Recibe un string con el formato user-pass
		texto = texto.gsub(" ","") #Quita todos los espacios " "
		texto = texto.gsub("-",",") #Sustituye "-" por ","
		u_p = texto.split(",") #Crea una lista con el formato [user,pass]
		if not Usuario.user_existe(u_p[0])
			$users_registrados[$users_registrados.length] = Usuario.new(u_p[0],u_p[1]) #Agrega a final de lista global a objeto tipo Usuario 
			archivo = File.new("users.txt","a+") #Abre el archivo "users", si no existe lo crea
			archivo.puts texto
			archivo.close
			return true
		else
			return false
		end
	end

	def self.user_existe(user) # Verifica que un usuario exista
		cont = 0 #Contador para recorrer lista de usuarios registrados
		while cont < $users_registrados.length #Verifica que el contador sea menor a largo de la lista de usuarios registrados
			if $users_registrados[cont].getUser == user  #Verifica que usuario sea igual al usuario del sistema
				return true #En caso de serlo, retorna true
			end
			cont = cont + 1 #Aumenta contador
		end
		false #Retorna falso en caso de no existir ningun usuario igual en el sistema
	end

	def self.LogUser(texto) # Verifica que el usuario y contrasenha sean validos
		texto = texto.gsub(" ","") #Quita todos los espacios " "
		texto = texto.gsub("-",",") #Sustituye "-" por ","
		u_p = texto.split(",") #Crea una lista con el formato [user,pass]
		e_user = u_p[0] #Agarra usuario
		e_pass = u_p[1] #Agarra Pass
		cont = 0 #Contador para recorrer lista de usuarios registrados
		while cont < $users_registrados.length #Verifica que el contador sea menor a largo de la lista de usuarios registrados
			if $users_registrados[cont].getUser == e_user #Verifica que usuario sea igual al usuario del sistema
				if $users_registrados[cont].getPass == e_pass #Verifica que la contrasenha sea igual a la del usuarios del sistema
					return true #En caso de serlo, retorna true
				end
				return false #En caso de no ser la contrasenha, devuelve false sin seguir verificando mas usuarios
			end
			cont = cont + 1 #Aumenta contador
		end
		false #Retorna falso en caso de no existir ningun usuario igual en el sistema
	end
end

class Pregunta############################################################################################################
	def initialize(preg,user)
		@IDPregunta = $ID + 1
		@ObjPregunta = preg
		@ObjRes = []
		@tags = []
		@user = user
	end

	def getID()
		@IDPregunta
	end

	def getPregunta()
		@ObjPregunta
	end

	def getRes()
		@ObjRes
	end

	def getUser()
		@user
	end

	def setRes(res)
		@ObjRes[@ObjRes.length] = res
	end

	def agregaTag(tag)
		@tags[@tags.length] = tag
	end

	def self.listaPreguntas()
		cont = 0
		str = "%%%" #separador de preguntas
		while cont < $all_preguntas.length
			str = "#{str}/%/#{$all_preguntas[cont].getID()}/%/#{$all_preguntas[cont].getPregunta()}/%/#{$all_preguntas[cont].getTags()}"
			cont+=1
		end
		str
	end

	def self.crearPregunta(preg,user)
		res = Pregunta.new(preg,user)
		$all_preguntas[$all_preguntas.length] = res
	end

	def self.preguntasUser(user)
		res = "%%%"
		cont = 0
		while $all_preguntas.length > cont
			if $all_preguntas[cont].getUser = user
				res = "#{res}/%/#{$all_preguntas[cont].getID()}/%/#{$all_preguntas[cont].getPregunta()}"
			end
			cont+=1
		end
		res
	end

	def self.borrarPregunta(id)
		$all_preguntas.delete(id)
	end

	def self.agregaTagPregunta(tag,id)
		cont = 0
		while $all_preguntas.length > cont
			if $all_preguntas[cont].getID = id

				res = "#{res}/%/#{$all_preguntas[cont].getID()}/%/#{$all_preguntas[cont].getPregunta()}"
			end
			cont+=1
		end
	end
end

class Respuesta###########################################################################################################
	def initialize(res,user)
		@respuesta = res
		@user = user
	end

	def getRes()
		@respuesta
	end

	def getUser()
		@user
	end
	
	def self.responde_pregunta(res,id,user)
		cont = 0
		while cont < $all_preguntas.length
			if id = $all_preguntas[cont].getID
				$all_preguntas[cont].setRes(Respuesta.new(res,user))
			end
			cont+=1
		end 
	end

	def self.listaRespuestas(id)
		cont = 0
		str = "%%%" #separador de preguntas
		while cont < $all_preguntas.length
			if id = $all_preguntas[cont].getID
				l_res = $all_preguntas[cont].getRes
				cont = 0
				while l_res.length > cont
					str = "#{str}%%%#{l_res[cont].getUser}/%/#{l_res[cont].getRes()}"
					cont+=1
				end
				return str
			end
			cont+=1
		end
		str
	end
end