import source.fases.Fase0.pantallaInformativa.*
import wollok.game.*
import source.personajes.jugador.*
import source.fases.Fase2.transicionDias.*
import source.pantallas.pantallaPerdisteFase1.*

import source.personajes.personajes.*

object refugio {
  const almacen = []
  var property position = game.at(9, 13)
  const estado = "abierta"
  const sprite = ("otros/escotilla/escotilla-" + estado) + ".png"
  
  method image() = sprite
  method esAgarrable() = false
  method atravesable() = false
  
  method guardar(objetos) {
    almacen.addAll(objetos)
  }
  
  method consumir(nombre) {
    almacen.remove(almacen.find({ item => item.nombre() == nombre }))
  }
  
  method puedeEntrar(jugador) {
    if (self.estaCerca(jugador)) {
      jugador.soltar()

      //el jugador se mete al refugio cuando se termina el tiempo
      self.guardar([jugador.personajeElegido().crearPersonaje()])
      transicionDias.mostrar()
    } else {
      pantallaPerdisteFase1.mostrar()
    }
  }
  
  method estaCerca(jugador) = self.position().distance(jugador.position()) <= 1
  
  method objetosGuardados() = almacen.filter({ cosa => cosa.esObjeto() })

  method familiaresGuardados() = almacen.filter({ cosa => !cosa.esObjeto() })

  method familiaresVivos() = self.familiaresGuardados().filter({ familiar => familiar.vive() })

  method tiene(item, cantidad) = almacen.filter(
    { unItem => unItem.nombre() == item }
  ).size() >= cantidad

  method reiniciar() { almacen.clear() }

}