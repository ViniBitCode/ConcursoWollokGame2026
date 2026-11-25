import source.utilsconfig.config.*
import source.utilsconfig.utils.*
import wollok.game.*
import source.pantallas.pantalla.*
import source.fases.Fase0.menuPrincipal.*
import source.fases.Fase2.libreta.*

object nivelBunker inherits Pantalla {

  override method imagenFondo() = "fondos/Fase2/imagenFondoDeBunker.png"
  
  override method configurarFondo() {
    game.addVisual(libretaCentral)
    libretaCentral.mostrarFlechas()
  }
  
  override method configurarTeclas() {
    game.onClickDo(
      { celdaClickeada =>
        const flechas = [flechaIzquierda, flechaDerecha, flechaCentral]
        const tocadas = flechas.filter(
          { flecha => utils.seleccionarOpcion(
              celdaClickeada,
              flecha.position(),
              flecha.ancho(),
              flecha.alto()
            ) }
        )
        if (!tocadas.isEmpty()) tocadas.first().alTocar()
      }
    )
  }
}