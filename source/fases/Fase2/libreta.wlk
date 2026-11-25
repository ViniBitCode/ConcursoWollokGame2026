import source.personajes.personajes.*
import source.fases.Fase2.transicionDias.*
import wollok.game.*
import source.fases.Fase2.eventosManager.*
import source.sonidoManager.sonidoManager.*
import source.refugio.refugio.*

object libretaCentral {
  var paginasLibreta = []
  var indicePagina = 0
  
  method position() = game.at(7, 2)
  
  method paginaActual() = paginasLibreta.get(indicePagina)
  
  method image() = self.paginaActual().image()
  
  method configurarLibreta(fondoPrimerPagina) {
    paginasLibreta.clear()
    indicePagina = 0
    
    paginasLibreta.add(new Pagina(imagenPagina = fondoPrimerPagina))
    paginasLibreta.add(segundaPagina)
    paginasLibreta.add(terceraPagina)
  }
  
  method mostrarFlechas() {
    game.addVisual(flechaIzquierda)
    game.addVisual(flechaDerecha)
    game.addVisual(flechaCentral)
  }
  
  method moverPagina(desplazamiento, sonido) {
    self.paginaActual().ocultarPagina()
    indicePagina = (indicePagina + desplazamiento + paginasLibreta.size()) % paginasLibreta.size()
    self.paginaActual().mostrarPagina()
    sonidoManager.reproducirEfectoDeSonido(sonido)
  }

  method siguientePagina() {
    self.moverPagina(1, "audios/PasarPagina2.wav")
  }
  
  method paginaAnterior() {
    self.moverPagina(-1, "audios/PasarPagina1.wav")
  }

}

class Pagina {
  const imagenPagina
  
  method image() = imagenPagina
  
  method mostrarPagina() {
    
  }
  
  method ocultarPagina() {
    
  }
}

class PaginaConIconos {
  const iconos = []
  const inicioX = 10
  const finFila = 22

  method image() = "fondos/Fase2/libretaTexto.png"

  method contenidoPagina()

  method separacionFilas() = 1

  method mostrarPagina() {
    self.ocultarPagina()
    var posX = 10
    var posY = 12

    self.contenidoPagina().forEach({ icono =>
      iconos.add(new IconoObjeto(position = game.at(posX, posY), sprite = icono.sprite()))
      posX += 2
      if (posX >= finFila) {
        posX = inicioX
        posY -= self.separacionFilas()
      }
    })
    iconos.forEach({ icono => game.addVisual(icono) })
  }

  method ocultarPagina() {
    iconos.forEach({ icono => if (game.hasVisual(icono)) game.removeVisual(icono) })
    iconos.clear()
  }
}

object segundaPagina inherits PaginaConIconos {
  override method contenidoPagina() = refugio.objetosGuardados().sortedBy({ uno, otro => uno.nombre() < otro.nombre() })
}

object terceraPagina inherits PaginaConIconos {
  override method contenidoPagina() = refugio.familiaresGuardados()

  override method separacionFilas() = 2
}

class IconoObjeto {
  const property position
  const sprite
  
  method image() = sprite
}

object flechaIzquierda {
  method image() = "fondos/Fase2/flechaIzquierda.png"
  
  method ancho() = 2
  
  method alto() = 2
  
  method alTocar() {
    libretaCentral.paginaAnterior()
  }
  
  method position() = game.at(11, 4)
}

object flechaDerecha {
  method image() = "fondos/Fase2/flechaDerecha.png"
  
  method ancho() = 2
  
  method alto() = 2
  
  method alTocar() {
    libretaCentral.siguientePagina()
  }
  
  method position() = game.at(18, 4)
}

object flechaCentral {
  method image() = "fondos/Fase2/flechaCentral.png"
  
  method ancho() = 1
  
  method alto() = 1
  
  method alTocar() {
    transicionDias.mostrar()
  }
  
  method position() = game.at(15, 4)
}