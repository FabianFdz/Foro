$users_registrados = [] #lista que contiene objetos tipo Usuario
$all_preguntas = [] #lista de preguntas de todos los usuarios
$ID = 0 #ID de preguntas

class Usuario
	def initialize(user,pass) # Constructor de Usuario
		@user = user # Usuario
		@pass = pass # Contrasenha
		@preguntas = [] # Preguntas que ha hecho
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

	def agregaPregunta(pregunta)
		@preguntas[@preguntas.length] = pregunta
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
			return "Registro existoso"
		else
			return "Usuario existe"
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

class Pregunta
	def initialize(preg)
		@IDPregunta = $ID + 1
		@ObjPregunta = preg
		@ObjRes = []
	end
	
	def self.listaPreguntas
		return $all_preguntas
	end

	def self.crearPregunta(preg)
		
	end
end