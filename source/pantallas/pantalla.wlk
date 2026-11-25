import wollok.game.*

class Pantalla {
  method mostrar() {
    game.clear()
    game.addVisual(fondo)
    fondo.imagen(self.imagenFondo())
    self.configurarFondo()
    self.configurarTeclas()
  }
  
  method imagenFondo()
  
  method configurarFondo() {
    
  }
  
  method configurarTeclas() {
    
  }
}

object fondo {
  var property imagen = ""
  
  method position() = game.origin()
  
  method image() = imagen
}