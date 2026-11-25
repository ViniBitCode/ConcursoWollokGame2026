import wollok.game.*
import source.pantallas.pantalla.*
import source.fases.Fase0.pantallaInformativa.*
import source.utilsconfig.utils.*
import source.utilsconfig.config.*
import source.fases.Fase0.menuSelector.*

import source.sonidoManager.sonidoManager.*

class OpcionMenu {
  const property position
  const imagen
  const property destino
  
  method image() = imagen
}

object menuPrincipal inherits Pantalla {
  const property ancho_opciones_menu_inicial = 4
  const property alto_opciones_menu_inicial = 4
  const opciones = [
    new OpcionMenu(
      position = game.at(2, 11),
      imagen = "fondos/Fase0/logoControles.png",
      destino = pantallaControles
    ),
    new OpcionMenu(
      position = game.at(2, 6),
      imagen = "fondos/Fase0/logoJugar.png",
      destino = selector
    ),
    new OpcionMenu(
      position = game.at(2, 1),
      imagen = "fondos/Fase0/logoCreditos.png",
      destino = pantallaCreditos
    )
  ]
  
  override method imagenFondo() = "fondos/Fase0/fondoMenuPrincipal.png"
  
  override method configurarFondo() {
    opciones.forEach({ opcion => game.addVisual(opcion) })
  }
  
  override method configurarTeclas() {
    game.onClickDo(
      { celdaClickeada =>
        const clickeadas = opciones.filter(
          { opcion => utils.seleccionarOpcion(
              celdaClickeada,
              opcion.position(),
              self.ancho_opciones_menu_inicial(),
              self.alto_opciones_menu_inicial()
            ) }
        )
        if (!clickeadas.isEmpty()){
          sonidoManager.reproducirEfectoDeSonido("audios/ClickSound.wav")
          clickeadas.first().destino().mostrar()
        } 
      }
    )
  }
}