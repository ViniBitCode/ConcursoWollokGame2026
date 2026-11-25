import wollok.game.*

object sonidoManager {
  var sonidoBackground = ""
  var efectoSonido = ""
  
  method configBackground(cancionDeFondo) {
    sonidoBackground = game.sound(cancionDeFondo)
    sonidoBackground.shouldLoop(true)
    sonidoBackground.volume(0.2)
    return sonidoBackground
  }
  
  method cambiarSonidoBackground(cancionDeFondo) {
    sonidoBackground = self.configBackground(cancionDeFondo)
    sonidoBackground.play()
  }
  
  method frenarSonidoBackground() {
    sonidoBackground.stop()
  }
  
  method reproducirEfectoDeSonido(efecto) {
    efectoSonido = game.sound(efecto)
    efectoSonido.volume(0.3)
    efectoSonido.play()
  }
}