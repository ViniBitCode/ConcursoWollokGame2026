import source.fases.Fase2.eventosManager.*
import source.personajes.personajes.*
import wollok.game.*
import source.refugio.refugio.*
import source.items.item.*

class Evento {
  const opciones
  const property id_evento_ganaste = 0
  const property id_evento_perdiste = 0

  method efecto() {
    if (self.puedeSalvarse()) {
      self.opcionDisponible().forEach({ item => item.usar() })
      self.alSalvarse()
      return self.id_evento_ganaste()
    }
    self.alNoSalvarse()
    return self.id_evento_perdiste()
  }

  method alSalvarse() {}
  method alNoSalvarse() {}

  method puedeSalvarse() = opciones.any({ combo => self.comboDisponible(combo) })

  method opcionDisponible() = opciones.find({ combo => self.comboDisponible(combo) })

  method comboDisponible(combo) = combo.all({ item => refugio.tiene(item.nombre(), combo.occurrencesOf(item)) })
}

class EventoEliminacionItemOPerder inherits Evento {
  override method alNoSalvarse() {
    const familiaresVivos = refugio.familiaresVivos()
    if (familiaresVivos.isEmpty()) eventoManager.finalizarPartida()
    else familiaresVivos.anyOne().morir()
  }
}

const estasSecoComoLenguaDeLoro  = new EventoEliminacionItemOPerder(opciones = [[agua]],                                id_evento_perdiste = 1)
const tenesAltaLija              = new EventoEliminacionItemOPerder(opciones = [[sopa]],                                id_evento_perdiste = 2)
const invasionDeFaunaAustraliana = new EventoEliminacionItemOPerder(opciones = [[insecticida], [libro]],                id_evento_perdiste = 3)
const llueveMasAdentroQueAfuera  = new EventoEliminacionItemOPerder(opciones = [[maletin]],                             id_evento_perdiste = 4)
const tasPachucho                = new EventoEliminacionItemOPerder(opciones = [[insecticida], [botiquin]],             id_evento_perdiste = 5)
const lamentablementeGaga        = new EventoEliminacionItemOPerder(opciones = [[tableroDamas], [cartas], [radio]],     id_evento_perdiste = 6)
const alguienSeCago              = new EventoEliminacionItemOPerder(opciones = [[mascara], [libro]],                    id_evento_perdiste = 7)
const siEntraElChorro            = new EventoEliminacionItemOPerder(opciones = [[escopeta, balas], [hacha], [candado]], id_evento_perdiste = 8)

object patearLaCalle inherits Evento(opciones = [[mascara, libro]]) {
  override method alSalvarse() {
    5.times({ _ => refugio.guardar([agua.crear()]) })
    5.times({ _ => refugio.guardar([sopa.crear()]) })
  }

  override method alNoSalvarse() {
    refugio.guardar([agua.crear(), sopa.crear(), botiquin.crear(), mapa.crear()])
  }

}

const rescateDeGendarmeria = new Evento(opciones = [[radio]], id_evento_ganaste = 12)
const escapeConMartuYFeli = new Evento(opciones = [[mapa]], id_evento_ganaste = 13)
const viajeAstralConElCapitanBeto = new Evento(opciones = [[sopa, sopa, sopa, sopa], [agua, agua, agua, agua]], id_evento_ganaste = 14)