import wollok.game.*
import source.pantallas.pantalla.*
import source.fases.Fase0.menuPrincipal.*
import source.fases.Fase1.fondoDeNivel.*
import source.refugio.refugio.*
import source.sonidoManager.sonidoManager.*
import source.utilsconfig.utils.*
import source.utilsconfig.config.*
import source.personajes.jugador.*


class PantallaInformativa inherits Pantalla {
  const imagen
  
  override method imagenFondo() = imagen
  
  override method configurarTeclas() {
    sonidoManager.reproducirEfectoDeSonido("audios/ClickSound.wav")
    keyboard.backspace().onPressDo({ menuPrincipal.mostrar() })
  }
}

object pantallaControles inherits PantallaInformativa (
  imagen = "fondos/Fase0/fondoControles.png"
) {
  
}

object pantallaCreditos inherits PantallaInformativa (
  imagen = "fondos/Fase0/fondoCreditos.png"
) {
  
}


