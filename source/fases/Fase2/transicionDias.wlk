import source.refugio.refugio.*
import source.personajes.personajes.*
import source.sonidoManager.sonidoManager.*
import source.fases.Fase2.evento.*
import source.fases.Fase3.pantallaFinal.*
import source.fases.Fase0.pantallaInformativa.*
import source.utilsconfig.config.*
import source.fases.Fase2.eventosManager.*
import wollok.game.*
import source.pantallas.pantalla.*
import source.fases.Fase2.nivelBunker.*

object transicionDias inherits Pantalla {
  var diaActual = 0
  const imagenesTransicion = [
    "fondos/Fase2Transiciones/TransicionDia01.png",
    "fondos/Fase2Transiciones/TransicionDia02.png",
    "fondos/Fase2Transiciones/TransicionDia03.png",
    "fondos/Fase2Transiciones/TransicionDia04.png",
    "fondos/Fase2Transiciones/TransicionDia05.png",
    "fondos/Fase2Transiciones/TransicionDia06.png",
    "fondos/Fase2Transiciones/TransicionDia07.png",
    "fondos/Fase2Transiciones/TransicionDia08.png",
    "fondos/Fase2Transiciones/TransicionDia09.png",
    "fondos/Fase2Transiciones/TransicionDia10.png",
    "fondos/Fase2Transiciones/TransicionDia11.png",
    "fondos/Fase2Transiciones/TransicionDia12.png",
    "fondos/Fase2Transiciones/TransicionDia13.png",
    "fondos/Fase2Transiciones/TransicionDia14.png",
    "fondos/Fase2Transiciones/TransicionDia15.png"
  ]
  

  override method imagenFondo() = imagenesTransicion.get(diaActual)
  
  override method configurarFondo() {
    if (!eventoManager.partidaFinalizada()) {
      diaActual += 1
      
      if (diaActual == 3) eventoManager.agregarEventos([patearLaCalle])
      
      if (diaActual == 7) {
        const finales = [
          rescateDeGendarmeria,
          escapeConMartuYFeli,
          viajeAstralConElCapitanBeto
        ]
        eventoManager.agregarEventos(finales)
      }
      
      if (diaActual == 15) {
        const familiares = refugio.familiaresGuardados()
        familiares.forEach({ familiar => familiar.morir() })
      }
      
      eventoManager.generarEvento(diaActual)
      
      game.schedule(3000, { nivelBunker.mostrar() })
    } else {
      pantallaFinal.mostrar()
    }
  }
  
  override method configurarTeclas() {
    
  }
  
  method reiniciar() {
    diaActual = 1
  }
}