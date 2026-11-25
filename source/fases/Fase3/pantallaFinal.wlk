import source.utilsconfig.config.*
import wollok.game.*
import source.pantallas.pantalla.*

import source.sonidoManager.sonidoManager.*

object pantallaFinal inherits Pantalla {

  const fondoPantallaFinal = new Dictionary()

  const sonidosFinales = new Dictionary()

  override method initialize() {

    fondoPantallaFinal.put(12, "fondos/Fase2FinalesBuenos/eventoRescateGendarmeria.png")
    fondoPantallaFinal.put(13, "fondos/Fase2FinalesBuenos/eventoEscapeConMartuYFeli.png")
    fondoPantallaFinal.put(14, "fondos/Fase2FinalesBuenos/eventoViajeAstralConElCapitanBeto.png")

    sonidosFinales.put(12, "audios/SanLorenzo.wav")
    sonidosFinales.put(13, "audios/IKnowYouWantME.wav")
    sonidosFinales.put(14, "audios/ElAnilloDelCapitanBeto.wav")
    
  }

  const fondoPerdiste = "fondos/Fase3/fondoCreditos.png"
  var fondoActual = fondoPerdiste

  override method imagenFondo() = fondoActual

  method cambiarFondo(nuevoFondoIndice) { 


    sonidoManager.cambiarSonidoBackground(sonidosFinales.get(nuevoFondoIndice))
    fondoActual = fondoPantallaFinal.get(nuevoFondoIndice) 
    
  }
  
  override method configurarFondo() {
    
  }
  
  override method configurarTeclas() {
    keyboard.backspace().onPressDo({ configGlobal.reiniciarJuego() })
  }

  method reiniciar() { fondoActual = fondoPerdiste }


}