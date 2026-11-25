import wollok.game.*
import source.sonidoManager.sonidoManager.*
import source.refugio.refugio.*
import source.personajes.jugador.*
import source.utilsconfig.config.*

object reloj {
  var property position = game.at(23, 10)
  var property contador = 0
  var tiempoCambioEstado = 12500 

  method image() = self.sprite()
  
  method sprite() = ("otros/reloj/reloj-" + contador) + ".png"
  
  method cambiarSprite() {
    contador += 1
  }

  method actualizarTiempoCambioEstado(nuevoTiempo){
    tiempoCambioEstado = nuevoTiempo
  }
  
method configureSchedule(){
      game.onTick(tiempoCambioEstado, "reloj", 
        { 
          self.cambiarSprite()
            if(contador == 1){
            game.removeTickEvent("tubaLoop")
            sonidoManager.reproducirEfectoDeSonido("audios/Sirena.wav")
            game.schedule(500, {
              sonidoManager.reproducirEfectoDeSonido("audios/ScavengeTheme.wav")
            })
          }
          if(contador == configGlobal.ultimo_valor_contador_reloj()){
            game.removeTickEvent("reloj")
            refugio.puedeEntrar(jugador)
          }
        }
      )
  }

  method iniciar() { 
    self.reiniciar() 
    self.configureSchedule() 
    game.schedule(3000, {
      sonidoManager.reproducirEfectoDeSonido("audios/Tuba.wav")
      game.onTick(8200, "tubaLoop", {sonidoManager.reproducirEfectoDeSonido("audios/Tuba.wav")
      })
    })
  }

  method reiniciar() { contador = 0 }
}