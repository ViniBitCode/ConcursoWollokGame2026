import source.utilsconfig.utils.*
import source.refugio.refugio.*

class Item {
  var property position = null
  const property nombre
  const property sprite
  const property peso

  method image() = sprite

  method atravesable() = false
  method esAgarrable() = true
  method esObjeto() = true
}

class TipoDeItem {
  const property nombre
  const sprite
  const peso

  method crear() = new Item(nombre = nombre, sprite = sprite, peso = peso)

  method ponerEn(posicion) {
    const item = self.crear()
    item.position(posicion)
    return item
  }

  method usar()
}

class Consumible inherits TipoDeItem {
  override method usar() {
    refugio.consumir(nombre)
  }
}

class Durable inherits TipoDeItem {
  override method usar() {
    if (self.seRompe()) refugio.consumir(nombre)
  }

  method seRompe() = utils.divisiblePor((0 .. 255).anyOne(), 7)
}

const agua        = new Consumible(nombre = "AGUA", peso = 1, sprite = "items/agua.png")
const sopa        = new Consumible(nombre = "SOPA", peso = 1, sprite = "items/sopa.png")
const balas       = new Consumible(nombre = "BALAS", peso = 1, sprite = "items/balas.png")
const candado     = new Consumible(nombre = "CANDADO", peso = 1, sprite = "items/candado.png")
const insecticida = new Consumible(nombre = "INSECTICIDA", peso = 1, sprite = "items/insecticida.png")
const botiquin    = new Consumible(nombre = "BOTIQUIN", peso = 2, sprite = "items/botiquin.png")

const cartas      = new Durable(nombre = "CARTAS", peso = 1, sprite = "items/cartas.png")
const libro       = new Durable(nombre = "LIBRO", peso = 1, sprite = "items/libro.png")
const linterna    = new Durable(nombre = "LINTERNA", peso = 1, sprite = "items/linterna.png")
const mapa        = new Durable(nombre = "MAPA", peso = 1, sprite = "items/mapa.png")
const mascara     = new Durable(nombre = "MASCARA", peso = 1, sprite = "items/mascara.png")
const radio       = new Durable(nombre = "RADIO", peso = 1, sprite = "items/radio.png")
const tableroDamas = new Durable(nombre = "TABLERO DE DAMAS", peso = 1, sprite = "items/tableroDeDamas.png")
const hacha       = new Durable(nombre = "HACHA", peso = 2, sprite = "items/hacha.png")
const escopeta    = new Durable(nombre = "ESCOPETA", peso = 2, sprite = "items/escopeta.png")
const maletin     = new Durable(nombre = "MALETIN", peso = 3, sprite = "items/maletin.png")