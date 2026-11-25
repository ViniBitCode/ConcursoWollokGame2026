import wollok.game.*
import source.items.item.*
//agrego personajes
import source.personajes.personajes.*

object x {
  const property position = game.origin()
  
  method dibujar(posX, posY) {
    
  }
  
  method atravesable() = false

  
  method esAgarrable() = false
}

object _ {
  const property position = game.origin()
  
  method dibujar(posX, posY) {
    
  }
  
  method atravesable() = true
  
  method esAgarrable() = false
}

object i {
  const property lugaresDeItems = []
  
  method dibujar(posX, posY) {
    lugaresDeItems.add(game.at(posX, posY))
  }
  
  method atravesable() = true
  
  method reiniciar() {
    lugaresDeItems.clear()
  }
}