import wollok.game.*

object utils {

    method seleccionarOpcion(unaPosicion, posicionCuadro, ancho, alto) = 
    unaPosicion.x().between(posicionCuadro.x(), (posicionCuadro.x() + ancho) - 1)  && unaPosicion.y().between(posicionCuadro.y(), (posicionCuadro.y() + alto) - 1)

    method divisiblePor(unNumero, otroNumero) = (unNumero % otroNumero) == 0

}