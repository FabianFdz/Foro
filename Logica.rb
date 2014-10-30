$users_registrados = [] #lista que contiene objetos tipo Usuario

class Usuario
	def initialize(user,pass)
		@user = user
		@pass = pass
		@preguntas = []
	end

	def getUser()
		@user
	end

	def self.cargar_txt() # => Carga los usuarios a memoria en caso de cierre de programa
		archivo = File.new("users.txt","a+") #Abre el archivo "users", si no existe lo crea
		archivo.rewind #Vamos a la primera linea del archivo
		lista_users = archivo.readlines #Lee todas las lineas y las mete a la variable en forma de lista
		cont = 0 #contador para recorrer lista
		while cont < lista_users.length
			temp = lista_users[cont].split(",")	#Los users y pass esta separados por "," (Comas) se crea una lista de esta forma [user,pass]
			$users_registrados[$users_registrados.length] = Usuario.new(temp[0],temp[1]) #Agrega a final de lista a objeto tipo Usuario 
			cont = cont + 1 #Aumenta contador
		end
		archivo.close
	end

	def self.registra_user(texto) # => Agrega el usuario al txt y a la lista de users_registrados. Recibe un string con el formato user-pass
		texto = texto.gsub(" ","") #Quita todos los espacios " "
		texto = texto.gsub("-",",") #Sustituye "-" por ","
		u_p = texto.split(",") #Crea una lista con el formato [user,pass]
		$users_registrados[$users_registrados.length] = Usuario.new(u_p[0],u_p[1]) #Agrega a final de lista global a objeto tipo Usuario 
		archivo = File.new("users.txt","a+") #Abre el archivo "users", si no existe lo crea
		archivo.puts texto
		archivo.close
	end

	def self.user_existe(user)
		cont = 0
		while cont < $users_registrados.length
			if $users_registrados[cont].getUser == user
				return "SI"
			end
			cont = cont + 1
		end
		"NO"
	end
end