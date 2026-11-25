import wollok.game.*
import source.items.item.*

object inventarioInGame {
  var inventario = self.vaciarInventario()
  const separacionEntreSlots = 2
  
  // Ver comentario en item.wlk respecto este constructor
  method crearSlotVacio() = new Item(
    nombre = "",
    peso = 0,
    sprite = "otros/mano/mano.png"
  )
  
  method dibujar() {
    var indice = 0
    inventario.forEach(
      { objeto =>
        objeto.position(self.calcularPosicion(indice))
        
        if (game.hasVisual(objeto)) game.removeVisual(objeto)

        game.addVisual(objeto) 
        indice += 1
        
      }
    )
  }
  
  method calcularPosicion(indice) {
    const posicionY = 6
    return game.at(self.posicionX(indice), posicionY)
  }
  
  method posicionX(indice) = 21 + (indice * separacionEntreSlots)
  
  method reemplazarSlot(objeto) {

    const tamanioMaximoInventario = 4
    const slotsOcupados = inventario.filter({ slot => !self.esVacio(slot) })

    if(game.hasVisual(objeto)){

      game.removeVisual(objeto)

      objeto.peso().times({ _ => 
        slotsOcupados.add(new Item(nombre = objeto.nombre(), peso = objeto.peso(), sprite = objeto.sprite()))
      })
    } 
    
    const cantidadSlotsLibres = tamanioMaximoInventario - slotsOcupados.size()
    const slotsLibres = []

    if(cantidadSlotsLibres > 0){
      cantidadSlotsLibres.times({ _ => slotsLibres.add(self.crearSlotVacio()) })
    }
    
    self.borrar()
    inventario = slotsOcupados + slotsLibres
    self.dibujar()
  }
  
  method esVacio(objeto) = objeto.nombre() == ""
  
  method resetear() {
    self.borrar()
    inventario = [
      self.crearSlotVacio(),
      self.crearSlotVacio(),
      self.crearSlotVacio(),
      self.crearSlotVacio()
    ]
    self.dibujar()
  }
  
  method borrar() {
    inventario.forEach(
      { objeto => if (game.hasVisual(objeto)) game.removeVisual(objeto) }
    )
  }

  method vaciarInventario() = (1 .. 4).map({ slot => self.crearSlotVacio() })

  method reiniciar() { inventario = self.vaciarInventario() }

}
