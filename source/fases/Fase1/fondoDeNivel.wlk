import wollok.game.*
import source.refugio.refugio.*
import source.personajes.jugador.*
import source.items.item.*
import source.fases.Fase1.reloj.*
import source.fases.Fase1.inventarioInGame.*
import source.fases.Fase1.celdasDeMapa.*
import source.personajes.personajes.*

object nivelCasa {
    const mapaCasa = [
    [x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x],
    [x, x, i, _, i, x, x, x, _, _, _, x, _, i, x, x, x, x, x, x],
    [x, _, _, _, _, _, _, x, _, x, _, x, _, _, _, _, _, _, i, x],
    [x, i, x, x, x, i, _, _, _, _, _, _, _, _, _, _, _, _, _, x],
    [x, x, x, x, x, x, x, x, i, _, _, x, x, _, _, _, _, _, i, x],
    [x, x, x, i, i, x, x, x, _, _, _, i, x, _, i, x, x, _, _, x],
    [x, i, _, _, _, _, _, _, _, _, _, _, x, _, x, x, x, x, _, x],
    [x, _, _, _, _, _, _, x, x, x, _, _, x, _, _, _, i, _, _, x],
    [x, x, i, _, _, x, x, x, i, _, _, i, x, i, _, _, _, _, i, x],
    [x, x, x, x, x, x, x, x, _, _, x, x, x, x, x, x, x, x, x, x],
    [x, x, x, i, _, _, _, _, _, _, _, _, _, _, i, x, x, x, x, x],
    [x, _, _, _, _, _, i, x, x, x, x, _, x, _, _, _, _, _, i, x],
    [x, _, x, x, x, _, _, x, x, x, x, _, x, _, _, i, _, _, _, x],
    [x, _, _, i, _, _, x, x, x, i, _, _, x, _, x, x, x, x, _, x],
    [x, i, _, _, _, i, x, x, x, i, _, i, x, _, i, _, _, _, _, x],
    [x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x, x]
  ]
  const itemsFaseUno = [
    agua,
    agua,
    agua,
    agua,
    sopa,
    sopa,
    sopa,
    sopa,
    sopa,
    balas,
    candado,
    insecticida,
    botiquin,
    cartas,
    libro,
    linterna,
    mapa,
    mascara,
    radio,
    tableroDamas,
    hacha,
    escopeta,
    maletin
  ]

  const familia = [ted, dolores, maryJane, timmy]
  
  method nivelCasaSettings() {
    self.dibujarFondo()
    self.dibujarReloj()
    self.dibujarBunker()
    self.dibujarPersonaje()
    self.dibujarObjetos()

  }
  
  method dibujarFondo() {
    var posY = mapaCasa.size() - 1
    mapaCasa.forEach(
      { fila =>
        var posX = 0
        fila.forEach({ celda =>  celda.dibujar(posX, posY)posX += 1})
        posY -= 1
      }
    )
  }
  
  method dibujarReloj() {
    game.addVisual(reloj)
    reloj.iniciar()
  }
  
  method dibujarBunker() {
    game.addVisual(refugio)
  }
  
  method dibujarPersonaje() {
    game.addVisual(jugador)
    inventarioInGame.dibujar()
  }
  
  method crearFamiliares() {
    const familiaresACrear = familia.filter({ integrante => integrante != jugador.personajeElegido() })
    return familiaresACrear.map({ integrante => integrante.crearPersonaje() })
  }
  
  method dibujarObjetos() {
    const lugaresLibres = i.lugaresDeItems().copy()

    const familiares = self.crearFamiliares()
    const objetos = itemsFaseUno + familiares

    objetos.forEach(
      { item =>
        if(!lugaresLibres.isEmpty()){
          const lugar = lugaresLibres.anyOne()
          lugaresLibres.remove(lugar)
          game.addVisual(item.ponerEn(lugar))
        }
        
      }
    )
  }

  method celdaEn(posicion) = mapaCasa.get(mapaCasa.size() - 1 - posicion.y()).get(posicion.x())

  method esTransitable(posicion) = self.celdaEn(posicion).atravesable()

  method estaLibre(posicion) = self.esTransitable(posicion) and !self.hayObstaculoEn(posicion)

  method hayObstaculoEn(posicion) = game.getObjectsIn(posicion).any({ objeto => !objeto.atravesable() })

}