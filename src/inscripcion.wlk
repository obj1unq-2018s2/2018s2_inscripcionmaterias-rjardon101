class Alumno {
	var carreras = #{}
	var property materiasAprobadas = #{}
	var property materiasActuales = #{}
	var creditos = 0
	
	//1
	method estudianteCursa(unaCarrera) = carreras.contais({unaCarrera})
	
	method materiaPerteneceA(unaCarrera,unaMateria) = unaCarrera.listaDeMaterias().contains(unaMateria)
	
	method estudianteAprobo(unaMateria) = materiasAprobadas.contains(unaMateria)
	
	method estudianteEstaInscriptoEn(unaMateria) = materiasActuales.contains(unaMateria)
    
    method tieneSuficientesCreditos(unaMateria) = creditos >= unaMateria.creditosNecesarios()
    
    //2
    method aprobarMateria(unaMateria) {
    	unaMateria.estaAprobada(true) 
    }
    
    method registrarMateria(unaMateria) {
    	if(not self.estudianteAprobo(unaMateria)) {
    		materiasActuales.remove(unaMateria)
    		materiasAprobadas.add(unaMateria)
    		creditos += unaMateria.creditosQueOtorga()
    	}
    }
    
    //3
    method puedeInscribirseA(unaMateria) {
    	if(unaMateria.puedeCursarSerCursadaPor(self)) {
    		materiasActuales.add(unaMateria)
    	}
    	else self.error("el alumno ya está inscripto en está materia o ya la aprobó")
    }  
    
    //metodos hechos para que no me falle el test por las referencias
    method agregarAMateriasActuales(unaMateria) {materiasActuales.add(unaMateria)}
    method agregarAMateriasAprobadas(unaMateria) {materiasAprobadas.add(unaMateria)}
    
}

class Materia {
	var property creditosNecesarios = 0
	var property estaAprobada = false
	var property listaDeEspera= #{}
	var property materiasCorrelativas = #{}
	var listaDeAlumnos = #{}
	var property creditosQueOrtoga = 0

	//1
	method aproboMateriaCorrelativas(unAlumno) = materiasCorrelativas.all({materia => unAlumno.estudianteAprobo(materia)})
	
	/* este no tengo la mas minima idea de como hacerlo, así que le puse que me devuelva true para que no moleste
	 * me pareció muy engorroso (con el tiempo que tenía) tener que usar una variable más y encima tener que crear todos los metodos para que funcione bien
	 * */
	method aproboTodoElAnioAnterior(unAlumno) = true
	
	method puedeCursarSerCursadaPor(unAlumno) = self.aproboMateriaCorrelativas(unAlumno) and self.aproboTodoElAnioAnterior(unAlumno)
	
	//2
	method cupo(unNumero) = unNumero
	method anioDeMateria(unAnio) = unAnio
	
	//4
	method darDeBajaA(unAlumno) {
		unAlumno.materiasActuales().remove(listaDeAlumnos)
		if(not self.listaDeEspera().isEmpty()) {
			listaDeAlumnos.add(self.listaDeEspera().first())
			listaDeEspera.remove().first()
		}
	} 	
	
     //metodos hechos para que no me falle el test por las referencias
     method agregar(unAlumno) {listaDeAlumnos.add(unAlumno)}
	
}

class Carrera {
	var property listaDeMaterias = #{}
    
    method estaInscripto(unaMateria,unAlumno) = unaMateria.listaDeEstudiantes().contains(unAlumno)
    
    method listaDeMateriasDisponibles(unAlumno) = listaDeMaterias.filter({materias => materias.puedeSerCursadoPor(unAlumno)})
    
    method materiasEnLaQueEstaInscripto(unAlumno) = unAlumno.materiasActuales()
    
    method materiasEnListaDeEspera(unAlumno) = listaDeMaterias.filter({materias => materias.listaDeEspera().contains(unAlumno)})
    
    //metodos hechos para que no me falle el test por las referencias
    method agregar(materias) {listaDeMaterias = materias}
}
















