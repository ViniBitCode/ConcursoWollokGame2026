import source.fases.Fase3.pantallaFinal.*
import source.fases.Fase2.nivelBunker.*
import wollok.game.*
import source.refugio.refugio.*
import source.fases.Fase2.evento.*
import source.fases.Fase2.libreta.*

object eventoManager {
  var property partidaFinalizada = false
  const eventosIniciales = [
    estasSecoComoLenguaDeLoro,
    estasSecoComoLenguaDeLoro,
    estasSecoComoLenguaDeLoro,
    tenesAltaLija,
    tenesAltaLija,
    tenesAltaLija,
    invasionDeFaunaAustraliana,
    llueveMasAdentroQueAfuera,
    tasPachucho,
    lamentablementeGaga,
    alguienSeCago,
    siEntraElChorro
  ]
  const listaImagenesBuenResultado = [
    "fondos/Fase2EventosBuenos/EventoBueno1.png",
    "fondos/Fase2EventosBuenos/EventoBueno2.png",
    "fondos/Fase2EventosBuenos/EventoBueno3.png",
    "fondos/Fase2EventosBuenos/EventoBueno4.png",
    "fondos/Fase2EventosBuenos/EventoBueno5.png",
    "fondos/Fase2EventosBuenos/EventoBueno6.png",
    "fondos/Fase2EventosBuenos/EventoBueno7.png",
    "fondos/Fase2EventosBuenos/EventoBueno8.png",
    "fondos/Fase2EventosBuenos/EventoBueno9.png",
    "fondos/Fase2EventosBuenos/EventoBueno10.png"
  ]
  var eventosPosibles = eventosIniciales.copy()
  const imagenesFinales = new Dictionary()
  
  override method initialize() {
    // Sobrevivir a alguno de los eventos de consumision
    imagenesFinales.put(0, "fondos/Fase2/libretaTexto.png")
    
    // Finales Malos
    imagenesFinales.put(1, "fondos/Fase2EventosMalos/finalMalo1.png")
    imagenesFinales.put(2, "fondos/Fase2EventosMalos/finalMalo2.png")
    imagenesFinales.put(3, "fondos/Fase2EventosMalos/finalMalo3.png")
    imagenesFinales.put(4, "fondos/Fase2EventosMalos/finalMalo4.png")
    imagenesFinales.put(5, "fondos/Fase2EventosMalos/finalMalo5.png")
    imagenesFinales.put(6, "fondos/Fase2EventosMalos/finalMalo6.png")
    imagenesFinales.put(7, "fondos/Fase2EventosMalos/finalMalo7.png")
    imagenesFinales.put(15, "fondos/Fase2EventosMalos/finalMalo8.png")
    imagenesFinales.put(16, "fondos/Fase2EventosMalos/finalMalo9.png")
    
    // Finales Buenos
    imagenesFinales.put(12, "fondos/Fase2FinalesBuenos/finalBueno1.png")
    imagenesFinales.put(13, "fondos/Fase2FinalesBuenos/finalBueno2.png")
    imagenesFinales.put(14, "fondos/Fase2FinalesBuenos/finalBueno3.png")
  }
  
  method finalizarPartida() {
    partidaFinalizada = true
  }
  
  method murieronTodos() = refugio.familiaresVivos().isEmpty()

  method generarEvento(diaActual) {
    const evento = eventosPosibles.anyOne()
    eventosPosibles.remove(evento)
    
    const resultadoEvento = evento.efecto()
    var imagenLibreta = imagenesFinales.get(resultadoEvento)
    
    if (resultadoEvento == 0) {
      const imagenBuenResultado = listaImagenesBuenResultado.anyOne()
      listaImagenesBuenResultado.remove(imagenBuenResultado)
      imagenLibreta = imagenBuenResultado
    }
    
    if (self.murieronTodos()) {
    partidaFinalizada = true
    imagenLibreta = imagenesFinales.get(16)
  }
    
    if (resultadoEvento.between(12, 14)) {
      partidaFinalizada = true
      imagenLibreta = imagenesFinales.get(resultadoEvento)
      pantallaFinal.cambiarFondo(resultadoEvento)
    }
    
    const ultimoDia = 15
    
    if (diaActual == ultimoDia) {
      partidaFinalizada = true
      imagenLibreta = imagenesFinales.get(ultimoDia)
    }
    
    
    libretaCentral.configurarLibreta(imagenLibreta)
  }
  
  method reiniciar() {
    eventosPosibles = eventosIniciales.copy()
    partidaFinalizada = false
  }
  
  method agregarEventos(eventos) {
    eventosPosibles.addAll(eventos)
  }
}