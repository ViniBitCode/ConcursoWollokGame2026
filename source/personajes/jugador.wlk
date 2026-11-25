import source.fases.Fase1.fondoDeNivel.*
import source.utilsconfig.config.*
import wollok.game.*
import source.items.item.*
import source.refugio.refugio.*
import source.fases.Fase1.inventarioInGame.*
import source.fases.Fase1.reloj.*
import source.sonidoManager.sonidoManager.*
import source.personajes.personajes.*

object jugador {
  var property position = game.at(10, 8)
  var personajeElegido = ted

  method personaje() = personajeElegido.nombre()
  method personaje(unPersonaje) { personajeElegido = unPersonaje }
  method personajeElegido() = personajeElegido

  var property direccionMirada = abajo
  const inventario = []
  const cargaMaxima = 4

  method image() = "personajes/" + self.personaje() + "/" + self.personaje() + "-" + direccionMirada + ".png"
  
  method mover(nuevaPosicion) {
    if (self.puedeMoverse()) {
      self.moverA(nuevaPosicion)
    }
  }
  
  method moverA(nuevaPosicion) {
    if (self.esValida(nuevaPosicion) && nivelCasa.estaLibre(nuevaPosicion)) {
      position = nuevaPosicion
    }
  }
  
  method esValida(nuevaPosicion) = nuevaPosicion.x().between(
    0,
    game.width() - 1
  ) && nuevaPosicion.y().between(1, game.height() - 2)

  method puedeMoverse() = reloj.contador() != configGlobal.ultimo_valor_contador_reloj()
  
  method arriba() {
    self.direccionMirada(arriba)
    self.mover(position.up(1))
  }
  
  method abajo() {
    self.direccionMirada(abajo)
    self.mover(position.down(1))
  }
  
  method izquierda() {
    self.direccionMirada(izquierda)
    self.mover(position.left(1))
  }
  
  method derecha() {
    self.direccionMirada(derecha)
    self.mover(position.right(1))
  }
  
  method agarrar() {
    const agarrables = game.getObjectsIn(self.posicionMirada()).filter(
      { objeto => objeto.esAgarrable() }
    )
    if (self.puedeAgarrar() and (!agarrables.isEmpty())) self.agarrarItem(
        agarrables.first()
      )
  }
  
  method agarrarItem(item) {
    if (self.leEntra(item)) {
      inventario.add(item)
      inventarioInGame.reemplazarSlot(item)
      sonidoManager.reproducirEfectoDeSonido("audios/Agarrar1.wav")
    } else {
      sonidoManager.reproducirEfectoDeSonido(personajeElegido.voz())
    }
  }

  
  method puedeAgarrar() = reloj.contador() >= 1
  
  method soltar() {
    if (self.tieneObjetos() and self.estaMirando(refugio)) {
      refugio.guardar(inventario)
      inventario.clear()
      inventarioInGame.resetear()
      sonidoManager.reproducirEfectoDeSonido("audios/Soltar1.wav")
    }
  }
  
  method leEntra(objeto) = (self.carga() + objeto.peso()) <= self.cargaMaxima()
  
  method estaMirando(objeto) = objeto.position() == self.posicionMirada()
  
  method posicionMirada() = direccionMirada.posicionSiguiente(self.position())
  
  method carga() = inventario.sum({ objeto => objeto.peso() })
  
  method cargaMaxima() = cargaMaxima
  
  method tieneObjetos() = inventario.size() > 0
  
  method reiniciar() {
    position = game.at(10, 8)
    direccionMirada = derecha
    personajeElegido = ted
    inventario.clear()
  }
}

object arriba {
  method posicionSiguiente(posicionActual) = posicionActual.up(1)
}

object abajo {
  method posicionSiguiente(posicionActual) = posicionActual.down(1)
}

object izquierda {
  method posicionSiguiente(posicionActual) = posicionActual.left(1)
}

object derecha {
  method posicionSiguiente(posicionActual) = posicionActual.right(1)
}