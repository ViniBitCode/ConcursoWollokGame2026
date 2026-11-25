import source.refugio.refugio.*
import source.personajes.jugador.*
import source.sonidoManager.sonidoManager.*
import source.fases.Fase1.fondoDeNivel.*

import wollok.game.*
import source.pantallas.pantalla.*
object pantallaJuego inherits Pantalla {
  override method imagenFondo() = "fondos/Fase1/fondoNivel1.png"
  
  override method configurarFondo() {
    nivelCasa.nivelCasaSettings()
    sonidoManager.frenarSonidoBackground()
  }
  
  override method configurarTeclas() {
    keyboard.w().onPressDo({ jugador.arriba() })
    keyboard.a().onPressDo({ jugador.izquierda() })
    keyboard.s().onPressDo({ jugador.abajo() })
    keyboard.d().onPressDo({ jugador.derecha() })
    keyboard.space().onPressDo(
      { if (jugador.tieneObjetos() and jugador.estaMirando(refugio))
          jugador.soltar()
        else jugador.agarrar()
      }
    )
  }
}