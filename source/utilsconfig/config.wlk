import source.fases.Fase3.pantallaFinal.*
import source.fases.Fase0.menuPrincipal.*
import source.sonidoManager.sonidoManager.*
import source.fases.Fase2.eventosManager.*
import source.fases.Fase2.transicionDias.*
import source.fases.Fase1.celdasDeMapa.*
import source.refugio.refugio.*
import source.fases.Fase1.inventarioInGame.*
import source.personajes.jugador.*
import source.fases.Fase1.reloj.*
import wollok.game.*

object configGlobal {
  // Para la Fase 0
  // Para la Fase 1
  const property ultimo_valor_contador_reloj = 6
  
  const reiniciables = [reloj, jugador, inventarioInGame, refugio, i, transicionDias, eventoManager, pantallaFinal]

  method reiniciarJuego() {
    reiniciables.forEach({ objeto => objeto.reiniciar() })
    sonidoManager.frenarSonidoBackground()
    sonidoManager.cambiarSonidoBackground("fondos/Fase0/sonidoMenu.wav")
    menuPrincipal.mostrar()
  }

}