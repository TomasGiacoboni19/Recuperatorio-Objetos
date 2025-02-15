class Receta {
    const ingredientes = []
    const dificultad

    method experienciaBase() = ingredientes.size() * dificultad
    method esDificil() = dificultad > 5 || ingredientes.size() > 10

    method similarA(otraReceta) = 
        self.ingredientes == otraReceta.ingredientes || (self.dificultad - otraReceta.dificultad).abs() <= 1
}

class RecetaGourmet inherits Receta {
    override method experienciaBase() = super().experienciaBase() * 2
    override method esDificil() = true
}

object calidadPobre {
    var experienciaMaxima = 4
    method experienciaFinal(expBase, plus) = expBase.min(experienciaMaxima)
}

object calidadNormal {
    method experienciaFinal(expBase, plus) = expBase
}

object calidadSuperior {
    method experienciaFinal(expBase, plus) = expBase + plus
}




class AcademiaCocina {
    const recetario = []
    const estudiantes = []
    
    method entrenar() {
        estudiantes.forEach({cocinero =>
            val receta = recetario.filter({c => cocinero.puedePreparar(c)}).max({c => c.experienciaBase()})
            if (receta != null) {
                cocinero.preparar(receta)
            }
        })
    }
}

/*class ComidaPreparada {
    const receta
    const calidad
    const plusExperiencia

    method experienciaAportada() {
        val expBase = receta.experienciaBase()
        return calidad.experienciaFinal(expBase, plusExperiencia)
    }
}*/


