
import source.fases.Fase1.reloj.*
import source.personajes.jugador.*
import source.fases.Fase0.menuPrincipal.*
import source.fases.Fase0.pantallaInformativa.*

import source.fases.Fase1.pantallaJuego.*

import source.utilsconfig.utils.*
import source.utilsconfig.config.*
import source.sonidoManager.sonidoManager.*

import source.pantallas.pantalla.*

import source.personajes.personajes.*


class OpcionSelector {
  const property position
  const property accion 
  const ancho = 0
  const alto = 0
  method efecto() = accion
  method contiene(celda) = utils.seleccionarOpcion(celda, self.position(), ancho, alto)
}

object selector inherits Pantalla {

  var property personaje = "ted"
  var property dificultad = "normal"

  method actualizarFondo() {
    fondo.imagen(self.imagenFondo())
  }

  method elegirPersonaje(unPersonaje) {
    jugador.personaje(unPersonaje)
    personaje = unPersonaje.nombre()
    self.actualizarFondo()
  }

  method elegirDificultad(nombre, tiempo) {
    reloj.actualizarTiempoCambioEstado(tiempo)
    dificultad = nombre
    self.actualizarFondo()
  }

const opciones = [
  new OpcionSelector(position = game.at(11, 8), ancho = 5, alto = 5, accion = { self.elegirPersonaje(ted) }),
new OpcionSelector(position = game.at(17, 8), ancho = 5, alto = 5, accion = { self.elegirPersonaje(dolores) }),

  new OpcionSelector(position = game.at(7, 3), ancho = 5, alto = 4, accion = { self.elegirDificultad("pichon", 15000) }),
  new OpcionSelector(position = game.at(12, 3), ancho = 5, alto = 4, accion = { self.elegirDificultad("normal", 12500) }),
  new OpcionSelector(position = game.at(17, 3), ancho = 5, alto = 4, accion = { self.elegirDificultad("2001", 10000) }),

  new OpcionSelector(position = game.at(12, 1), ancho = 7, alto = 1, accion = { pantallaJuego.mostrar() })
  ]

  override method imagenFondo() = "fondos/Fase0/selector/seleccion-" + personaje + "-" + dificultad + ".png"

  override method configurarTeclas() {
  game.onClickDo({ celdaClickeada =>
    const clickeadas = opciones.filter({ opcion => opcion.contiene(celdaClickeada) })

    if (!clickeadas.isEmpty()) {
      sonidoManager.reproducirEfectoDeSonido("audios/ClickSound.wav")
      clickeadas.first().accion().apply()
    }
  })

  keyboard.backspace().onPressDo({ menuPrincipal.mostrar() })
}
  
}