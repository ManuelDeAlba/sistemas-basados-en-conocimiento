; 1) En la compra de un iPhone 16 con tarjetas banamex, ofrece 24 meses sin intereses
(defrule ofrecer-meses-iphone16
    (orden (tipoproducto 1) (idproducto 2) (tarjeta banamex) (idcliente ?id))
    (cliente (id ?id) (nombre ?n))
    (not (orden-ofrecer-meses ?id)) ; Evitar que se procese la misma orden varias veces
    =>
    (assert (orden-ofrecer-meses ?id)) ; Marcar la orden como procesada
    (printout t ?n ", te ofrecemos 24 meses sin intereses en tu compra de un iPhone16 con tarjeta banamex." crlf)
)

; 2) En la compra de un Samsung S21 con tarjeta liverpool visa, ofrece 12 meses sin intereses
(defrule ofrecer-meses-samsungs21
    (orden (tipoproducto 1) (idproducto 1) (tarjeta liverpool) (idcliente ?id))
    (cliente (id ?id) (nombre ?n))
    (not (orden-ofrecer-meses ?id)) ; Evitar que se procese la misma orden varias veces
    =>
    (assert (orden-ofrecer-meses ?id)) ; Marcar la orden como procesada
    (printout t ?n ", te ofrecemos 12 meses sin intereses en tu compra de Samsung S21 con tarjeta liverpool visa." crlf)
)

; 3) En la compra al contado de una ThinkPad X1 Carbon y un iPhone 16, ofrece 100 pesos en vales por cada 1000 pesos de compra
(defrule ofrecer-vale-thinkpad-iphone16
    ; Compra de thinkpad
    (orden (id ?idorden) (tipoproducto 2) (idproducto 3) (tarjeta contado) (idcliente ?id) (cantidad ?cantthink))
    ; Compra de iphone
    (orden (id ?idorden2) (tipoproducto 1) (idproducto 2) (tarjeta contado) (idcliente ?id) (cantidad ?cantiphone))
    ; Producto thinkpad
    ?compu <- (computadora (idproducto 3) (precio ?p1) (stock ?stockthink))
    ; Producto iphone
    ?cel <- (celular (idproducto 2) (precio ?p2) (stock ?stockiphone))
    (cliente (id ?id) (nombre ?n))
    ; Evitar que se procese la misma orden varias veces (siempre lo va a ejecutar, excepto cuando los dos ya estén procesados)
    (or (not (ordenprocesada ?idorden)) (not (ordenprocesada ?idorden2)))
    =>
    ; Calcular el total de la compra
    (bind ?total (+ (* ?p1 ?cantthink) (* ?p2 ?cantiphone)))
    ; Comprobar si el total es mayor a 1000
    (if (>= ?total 1000) then
        ; Calcular el total de vales
        ; div sirve para obtener solo la parte entera
        (bind ?vales (div ?total 1000))
        ; Crear el vale
        (assert (vale (idcliente ?id) (texto ?n ", te ofrecemos " ?vales " vales de 100 pesos ($"(* ?vales 100)") por tu compra de " ?total " pesos.")))
        ; Mostrar el mensaje
        (printout t ?n ", te ofrecemos " ?vales " vales de 100 pesos ($"(* ?vales 100)") por tu compra de " ?total " pesos." crlf)
    )
)

; 4) Si el cliente compra un celular, ofrece una funda y mica con un 15% de descuento sobre accesorios
(defrule ofrecer-accesorios-celular
    (declare (salience -1)) ; Para que se ejecute después de las demás reglas
    (orden (id ?idorden) (tipoproducto 1) (idproducto ?idproducto) (idcliente ?id))
    (cliente (id ?id) (nombre ?n))
    (celular (marca ?marca) (modelo ?modelo) (idproducto ?idproducto))
    (not (orden-ofrecer-accesorios ?idorden)) ; Evitar que se procese la misma orden varias veces
    =>
    (assert (orden-ofrecer-accesorios ?idorden)) ; Marcar la orden como procesada
    (printout t ?n ", te ofrecemos una funda y mica con un 15% de descuento sobre accesorios por la compra de tu celular " ?marca " " ?modelo "." crlf)
)

; 5) Detectar si un cliente es minorista o mayorista < 10, > 10 en celulares
(defrule detectar-cliente-minorista-mayorista-celular
    (declare (salience -1)) ; Para que se ejecute después de las demás reglas
    (orden (id ?idorden) (tipoproducto 1) (idproducto ?idproducto) (idcliente ?idcliente) (cantidad ?cantidad))
    (cliente (id ?idcliente) (nombre ?nombre))
    ; Se comprueba que se tenga el suficiente stock, por si esto se ejecuta antes de la regla de stock
    (celular (idproducto ?idproducto) (marca ?marca) (modelo ?modelo))
    (not (ordencancelada ?idorden)) ; No ejecutar si la regla de stock ya canceló la orden
    (not (ordensegmentada ?idorden)) ; Evitar que se procese la misma orden varias veces
    =>
    (assert (ordensegmentada ?idorden)) ; Marcar la orden como procesada
    ; Imprimir mensaje de cliente minorista o mayorista < 10 o >= 10
    (printout t ?nombre ", compraste " ?cantidad " " ?marca " " ?modelo ", eres un cliente " (if (< ?cantidad 10) then "minorista" else "mayorista") "." crlf)
)

; 6) Detectar si un cliente es minorista o mayorista < 10, > 10 en computadoras
(defrule detectar-cliente-minorista-mayorista-computadora
    (declare (salience -1)) ; Para que se ejecute después de las demás reglas
    (orden (id ?idorden) (tipoproducto 2) (idproducto ?idproducto) (idcliente ?idcliente) (cantidad ?cantidad))
    (cliente (id ?idcliente) (nombre ?nombre))
    (computadora (idproducto ?idproducto) (marca ?marca) (modelo ?modelo))
    (not (ordencancelada ?idorden)) ; No ejecutar si la regla de stock ya canceló la orden
    (not (ordensegmentada ?idorden)) ; Evitar que se procese la misma orden varias veces
    =>
    (assert (ordensegmentada ?idorden)) ; Marcar la orden como procesada
    ; Imprimir mensaje de cliente minorista o mayorista < 10 o >= 10
    (printout t ?nombre ", compraste " ?cantidad " " ?marca " " ?modelo ", eres un cliente " (if (< ?cantidad 10) then "minorista" else "mayorista") "." crlf)
)

; 7) Detectar si un cliente es minorista o mayorista < 10, > 10 en accesorios
(defrule detectar-cliente-minorista-mayorista-accesorio
    (declare (salience -1)) ; Para que se ejecute después de las demás reglas
    (orden (id ?idorden) (tipoproducto 3) (idproducto ?idproducto) (idcliente ?idcliente) (cantidad ?cantidad))
    (cliente (id ?idcliente) (nombre ?nombre))
    (accesorio (idproducto ?idproducto) (nombre ?nombreaccesorio))
    (not (ordencancelada ?idorden)) ; No ejecutar si la regla de stock ya canceló la orden
    (not (ordensegmentada ?idorden)) ; Evitar que se procese la misma orden varias veces
    =>
    (assert (ordensegmentada ?idorden)) ; Marcar la orden como procesada
    ; Imprimir mensaje de cliente minorista o mayorista < 10 o >= 10
    (printout t ?nombre ", compraste " ?cantidad " " ?nombreaccesorio ", eres un cliente " (if (< ?cantidad 10) then "minorista" else "mayorista") "." crlf)
)

; 8) Actualizar stock celulares solo si hay suficiente, si no, otra regla manda mensaje
(defrule actualizar-stock-celulares
    (orden (id ?idorden) (tipoproducto 1) (idproducto ?idproducto) (cantidad ?cantidad) (idcliente ?idcliente))
    (cliente (id ?idcliente) (nombre ?n))
    ?celular <- (celular (marca ?marca) (modelo ?modelo) (idproducto ?idproducto) (stock ?stock))
    (not (ordenprocesada ?idorden)) ; Evitar que se procese la misma orden varias veces
    =>
    ; Si hay suficiente stock, actualizarlo
    ; Si no, otra regla se encarga de cancelar la orden
    (if (>= ?stock ?cantidad) then
        (bind ?nuevostock (- ?stock ?cantidad)) ; Calcular nuevo stock
        (modify ?celular (stock ?nuevostock)) ; Actualizar stock en la base de datos
        (assert (ordenprocesada ?idorden)) ; Marcar la orden como procesada
        ; Imprimir mensaje de stock actualizado
        (printout t ?n " realizó una compra (" ?marca " " ?modelo " - x" ?cantidad "), se ha actualizado el stock (" ?stock " -> " ?nuevostock ")" crlf)
    )
)

; 9) Actualizar stock computadoras solo si hay suficiente, si no, otra regla manda mensaje
(defrule actualizar-stock-computadoras
    (orden (id ?idorden) (tipoproducto 2) (idproducto ?idproducto) (cantidad ?cantidad) (idcliente ?idcliente))
    (cliente (id ?idcliente) (nombre ?n))
    ?computadora <- (computadora (marca ?marca) (modelo ?modelo) (idproducto ?idproducto) (stock ?stock))
    (not (ordenprocesada ?idorden)) ; Evitar que se procese la misma orden varias veces
    =>
    ; Si hay suficiente stock, actualizarlo
    ; Si no, otra regla se encarga de cancelar la orden
    (if (>= ?stock ?cantidad) then
        (bind ?nuevostock (- ?stock ?cantidad)) ; Calcular nuevo stock
        (modify ?computadora (stock ?nuevostock)) ; Actualizar stock en la base de datos
        (assert (ordenprocesada ?idorden)) ; Marcar la orden como procesada
        ; Imprimir mensaje de stock actualizado
        (printout t ?n " realizó una compra (" ?marca " " ?modelo " - x" ?cantidad "), se ha actualizado el stock (" ?stock " -> " ?nuevostock ")" crlf)
    )
)

; 10) Actualizar stock accesorios solo si hay suficiente, si no, otra regla manda mensaje
(defrule actualizar-stock-accesorios
    (orden (id ?idorden) (tipoproducto 3) (idproducto ?idproducto) (cantidad ?cantidad) (idcliente ?idcliente))
    (cliente (id ?idcliente) (nombre ?n))
    ?accesorio <- (accesorio (nombre ?nombreaccesorio) (idproducto ?idproducto) (stock ?stock))
    (not (ordenprocesada ?idorden)) ; Evitar que se procese la misma orden varias veces
    =>
    ; Si hay suficiente stock, actualizarlo
    ; Si no, otra regla se encarga de cancelar la orden
    (if (>= ?stock ?cantidad) then
        (bind ?nuevostock (- ?stock ?cantidad)) ; Calcular nuevo stock
        (modify ?accesorio (stock ?nuevostock)) ; Actualizar stock en la base de datos
        (assert (ordenprocesada ?idorden)) ; Marcar la orden como procesada
        ; Imprimir mensaje de stock actualizado
        (printout t ?n " realizó una compra (" ?nombreaccesorio " - x" ?cantidad "), se ha actualizado el stock (" ?stock " -> " ?nuevostock ")" crlf)
    )
)

; 11) Validar si hay suficiente stock de celulares. Si no, se cancela la orden
(defrule validar-stock-celulares
    ?orden <- (orden (id ?idorden) (tipoproducto 1) (idproducto ?idproducto) (idcliente ?idcliente) (cantidad ?cantidad))
    ?celular <- (celular (idproducto ?idproducto) (stock ?stock))
    (cliente (id ?idcliente) (nombre ?n))
    (not (ordenprocesada ?idorden)) ; Evitar que se procese la misma orden varias veces
    =>
    (if (< ?stock ?cantidad) then
        (retract ?orden) ; Eliminar la orden si no hay stock
        (assert (ordencancelada ?idproducto)) ; Marcar la orden como cancelada
        (printout t ?n ", no hay suficiente stock para el celular con id " ?idproducto ". La orden con id " ?idorden " ha sido cancelada. Intenta con una cantidad menor." crlf)
    )
)

; 12) Validar si hay suficiente stock de computadoras. Si no, se cancela la orden
(defrule validar-stock-computadoras
    ?orden <- (orden (id ?idorden) (tipoproducto 2) (idproducto ?idproducto) (idcliente ?idcliente) (cantidad ?cantidad))
    ?computadora <- (computadora (idproducto ?idproducto) (stock ?stock))
    (cliente (id ?idcliente) (nombre ?n))
    (not (ordenprocesada ?idorden)) ; Evitar que se procese la misma orden varias veces
    =>
    (if (< ?stock ?cantidad) then
        (retract ?orden) ; Eliminar la orden si no hay stock
        (assert (ordencancelada ?idproducto)) ; Marcar la orden como cancelada
        (printout t ?n ", no hay suficiente stock para la computadora con id " ?idproducto ". La orden con id " ?idorden " ha sido cancelada. Intenta con una cantidad menor." crlf)
    )
)

; 13) Validar si hay suficiente stock de accesorios. Si no, se cancela la orden
(defrule validar-stock-accesorios
    ?orden <- (orden (id ?idorden) (tipoproducto 3) (idproducto ?idproducto) (idcliente ?idcliente) (cantidad ?cantidad))
    ?accesorio <- (accesorio (idproducto ?idproducto) (stock ?stock))
    (cliente (id ?idcliente) (nombre ?n))
    (not (ordenprocesada ?idorden)) ; Evitar que se procese la misma orden varias veces
    =>
    (if (< ?stock ?cantidad) then
        (retract ?orden) ; Eliminar la orden si no hay stock
        (assert (ordencancelada ?idproducto)) ; Marcar la orden como cancelada
        (printout t ?n ", no hay suficiente stock para el accesorio con id " ?idproducto ". La orden con id " ?idorden " ha sido cancelada. Intenta con una cantidad menor." crlf)
    )
)