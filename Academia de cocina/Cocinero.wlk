import Recetas.*

class Cocinero {
    const comidasPreparadas = []

    method experienciaAdquirida() = 
        comidasPreparadas.sum({comida => comida.experienciaAportada()})
    
    method puedePreparar(receta) = false // Definido en subclases
    
    method preparar(receta) {
    if (self.puedePreparar(receta)) {
        comidasPreparadas.add(ComidaPreparada(receta, self.calidadObtenida(receta), self.plusExperiencia(receta)))
        self.evaluarNivel()
    } else {
        self.error("No puedes preparar esta receta")
    }
}

    
    method calidadObtenida(receta) = calidadNormal // Definido en subclases
    method superoNivel() = false // Definido en subclases
    method plusExperiencia(receta) = 0
    method evaluarNivel() {}
}

class CocineroPrincipiante inherits Cocinero {
    override method puedePreparar(receta) = not receta.esDificil()
    
    override method calidadObtenida(receta) = 
        if (receta.ingredientes.size() < 4) {
            receta.calidadNormal 
        }else calidadPobre
    
    override method superoNivel() = self.experienciaAdquirida() > 100
    
    override method evaluarNivel() {
        if (self.superoNivel()) self = new CocineroExperimentado(comidasPreparadas)
    }
}

class CocineroExperimentado inherits Cocinero {
    override method puedePreparar(receta) = 
        not receta.esDificil() || comidasPreparadas.any({comida => comida.receta.similarA(receta)})
    
    override method calidadObtenida(receta) = 
        if (self.perfecciono(receta)) calidadSuperior else calidadNormal
    
    override method plusExperiencia(receta) = comidasPreparadas.count({comida => comida.receta.similarA(receta)}) / 10
    
    method perfecciono(receta) = 
        self.experienciaAdquiridaEnSimilares(receta) >= 3 * receta.experienciaBase()
    
    method experienciaAdquiridaEnSimilares(receta) = 
        comidasPreparadas.filter({c => c.receta.similarA(receta)}).sum({c => c.experienciaAportada()})
    
    override method superoNivel() = comidasPreparadas.count({c => c.receta.esDificil()}) > 5
    
    override method evaluarNivel() {
        if (self.superoNivel()) {
            self.nivel = nivelChef 
    }
}

class CocineroChef inherits Cocinero {
    override method puedePreparar(receta) = true
    override method calidadObtenida(receta) = calidadSuperior
    override method plusExperiencia(receta) = comidasPreparadas.count({c => c.receta.similarA(receta)}) / 10
    override method superoNivel() = false
}
