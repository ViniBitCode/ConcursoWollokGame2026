
class Personaje{
    
    var property position = null
    var property nombre = ""
    var property sprite = ""
    var property prefijoSprite = ""
    const property peso = 0

    //agrego la variable para cuando perdes un evento que muera alguien
    var property vive = true
    method image() = sprite

    method ponerEn(posicion) {
        position = posicion
        return self
    }
        
    // Estos metodos se relacionan con las celdas en si. Considerar que las celdas son las del mapa (ej: las paredes) y los propios items.
    method atravesable() = false
    method esAgarrable() = true
    method esObjeto() = false

    method morir() {
        vive = false
        sprite = "personajes/" + self.prefijoSprite() + "/" + self.prefijoSprite() + "-muerto.png"
    }

}

class Familiar {
  const property nombre
  const peso
  const property voz

  method crearPersonaje() = new Personaje(
    nombre = nombre.toUpperCase(),
    peso = peso,
    prefijoSprite = nombre,
    sprite = "personajes/" + nombre + "/" + nombre + "-abajo.png"
  )
}

const ted = new Familiar(nombre = "ted", peso = 3, voz = "audios/NopeMale.wav")
const dolores = new Familiar(nombre = "dolores", peso = 2, voz = "audios/NopeFem1.wav")
const maryJane = new Familiar(nombre = "maryJane", peso = 3, voz = "audios/NopeFem1.wav")
const timmy = new Familiar(nombre = "timmy", peso = 2, voz = "audios/NopeMale.wav")