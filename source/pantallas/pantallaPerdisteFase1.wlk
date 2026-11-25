import source.utilsconfig.config.*
import wollok.game.*
import source.pantallas.pantalla.*
import source.fases.Fase0.menuPrincipal.*

object pantallaPerdisteFase1 inherits Pantalla {
  override method imagenFondo() = "fondos/Fase1/perdisteNivelCasa.png"
  
  override method configurarFondo() {
    game.schedule(2000, { game.addVisual(textoInformativo) })
  }
  
  override method configurarTeclas() {
    keyboard.backspace().onPressDo({ configGlobal.reiniciarJuego() })
  }
}

object textoInformativo {
  method position() = game.at(4, 0)
  
  method image() = "fondos/Fase1/textoInformativo.png"
}