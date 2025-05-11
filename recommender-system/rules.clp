;? REGLAS QUE MODIFICAN EL STOCK DE LOS PRODUCTOS SI HAY SUFICIENTE STOCK (ORDENPROCESADA SIRVE PARA MARCAR QUE YA FUE EDITADO Y NO DEBEN EJECUTARSE OTRA VEZ CIERTAS REGLAS)
; 1) Actualizar stock celulares solo si hay suficiente, si no, otra regla manda mensaje
(defrule actualizar-stock-celulares
    (declare (salience 10)) ; Ejecutar antes de las reglas normales
    (orden (id ?idorden) (tipoproducto 1) (idproducto ?idproducto) (cantidad ?cantidad) (idcliente ?idcliente))
    (cliente (id ?idcliente) (nombre ?n))
    ?celular <- (celular (marca ?marca) (modelo ?modelo) (idproducto ?idproducto) (precio ?precio) (stock ?stock))
    (not (ordenprocesada ?idorden)) ; Evitar que se procese la misma orden varias veces
    =>
    ; Si hay suficiente stock, actualizarlo
    ; Si no, otra regla se encarga de cancelar la orden
    (if (>= ?stock ?cantidad) then
        (bind ?nuevostock (- ?stock ?cantidad)) ; Calcular nuevo stock
        (bind ?total (* ?precio ?cantidad)) ; Calcular total de la compra
        (modify ?celular (stock ?nuevostock)) ; Actualizar stock en la base de datos
        (assert (ordenprocesada ?idorden)) ; Marcar la orden como procesada
        ; Imprimir mensaje de stock actualizado
        (printout t ?n " realizó una compra (" ?marca " " ?modelo " - x" ?cantidad " = $" ?total "), se ha actualizado el stock (" ?stock " -> " ?nuevostock ")" crlf)
    )
)

; 2) Actualizar stock computadoras solo si hay suficiente, si no, otra regla manda mensaje
(defrule actualizar-stock-computadoras
    (declare (salience 10)) ; Ejecutar antes de las reglas normales
    (orden (id ?idorden) (tipoproducto 2) (idproducto ?idproducto) (cantidad ?cantidad) (idcliente ?idcliente))
    (cliente (id ?idcliente) (nombre ?n))
    ?computadora <- (computadora (marca ?marca) (modelo ?modelo) (idproducto ?idproducto) (precio ?precio) (stock ?stock))
    (not (ordenprocesada ?idorden)) ; Evitar que se procese la misma orden varias veces
    =>
    ; Si hay suficiente stock, actualizarlo
    ; Si no, otra regla se encarga de cancelar la orden
    (if (>= ?stock ?cantidad) then
        (bind ?nuevostock (- ?stock ?cantidad)) ; Calcular nuevo stock
        (bind ?total (* ?precio ?cantidad)) ; Calcular total de la compra
        (modify ?computadora (stock ?nuevostock)) ; Actualizar stock en la base de datos
        (assert (ordenprocesada ?idorden)) ; Marcar la orden como procesada
        ; Imprimir mensaje de stock actualizado
        (printout t ?n " realizó una compra (" ?marca " " ?modelo " - x" ?cantidad " = $" ?total "), se ha actualizado el stock (" ?stock " -> " ?nuevostock ")" crlf)
    )
)

; 3) Actualizar stock accesorios solo si hay suficiente, si no, otra regla manda mensaje
(defrule actualizar-stock-accesorios
    (declare (salience 10)) ; Ejecutar antes de las reglas normales
    (orden (id ?idorden) (tipoproducto 3) (idproducto ?idproducto) (cantidad ?cantidad) (idcliente ?idcliente) (tarjeta ?tarjeta))
    (cliente (id ?idcliente) (nombre ?n))
    ?accesorio <- (accesorio (nombre ?nombreaccesorio) (idproducto ?idproducto) (precio ?precio) (stock ?stock))
    (not (ordenprocesada ?idorden)) ; Evitar que se procese la misma orden varias veces
    =>
    ; Si hay suficiente stock, actualizarlo
    ; Si no, otra regla se encarga de cancelar la orden
    (if (>= ?stock ?cantidad) then
        (bind ?nuevostock (- ?stock ?cantidad)) ; Calcular nuevo stock
        (bind ?total (* ?precio ?cantidad)) ; Calcular total de la compra
        (modify ?accesorio (stock ?nuevostock)) ; Actualizar stock en la base de datos
        (assert (ordenprocesada ?idorden)) ; Marcar la orden como procesada
        ; Imprimir mensaje de stock actualizado
        (if (neq ?tarjeta gratis) then
            (printout t ?n " realizó una compra (" ?nombreaccesorio " - x" ?cantidad " = $" ?total "), se ha actualizado el stock (" ?stock " -> " ?nuevostock ")" crlf)
        else
            (printout t ?n ", con tu regalo de (" ?nombreaccesorio " - x" ?cantidad ") se ha actualizado el stock (" ?stock " -> " ?nuevostock ")." crlf)
        )
    )
)

;? REGLAS DE VALIDACIÓN QUE ELIMINAN LA ORDEN SI NO HAY STOCK SUFICIENTE (SE TIENEN QUE EJECUTAR ANTES DE CUALQUIER OTRO MENSAJE O REGLA Y NO NECESITA UNA BANDERA PARA MARCARLA PORQUE SE ELIMINA LA ORDEN)
; 4) Validar si hay suficiente stock de celulares. Si no, se cancela la orden
(defrule validar-stock-celulares
    (declare (salience 10)) ; Ejecutar antes de las reglas normales
    ?orden <- (orden (id ?idorden) (tipoproducto 1) (idproducto ?idproducto) (idcliente ?idcliente) (cantidad ?cantidad))
    ?celular <- (celular (idproducto ?idproducto) (stock ?stock) (marca ?marca) (modelo ?modelo))
    (cliente (id ?idcliente) (nombre ?n))
    (not (ordenprocesada ?idorden)) ; Evitar que se procese la misma orden varias veces
    =>
    (if (< ?stock ?cantidad) then
        (retract ?orden) ; Eliminar la orden si no hay stock
        (printout t ?n ", no hay suficiente stock para el celular '" ?marca " " ?modelo "'. La orden con id " ?idorden " ha sido cancelada. Stock restante: " ?stock "." crlf)
    )
)

; 5) Validar si hay suficiente stock de computadoras. Si no, se cancela la orden
(defrule validar-stock-computadoras
    (declare (salience 10)) ; Ejecutar antes de las reglas normales
    ?orden <- (orden (id ?idorden) (tipoproducto 2) (idproducto ?idproducto) (idcliente ?idcliente) (cantidad ?cantidad))
    ?computadora <- (computadora (idproducto ?idproducto) (stock ?stock) (marca ?marca) (modelo ?modelo))
    (cliente (id ?idcliente) (nombre ?n))
    (not (ordenprocesada ?idorden)) ; Evitar que se procese la misma orden varias veces
    =>
    (if (< ?stock ?cantidad) then
        (retract ?orden) ; Eliminar la orden si no hay stock
        (printout t ?n ", no hay suficiente stock para la computadora '" ?marca " " ?modelo "'. La orden con id " ?idorden " ha sido cancelada. Stock restante: " ?stock "." crlf)
    )
)

; 6) Validar si hay suficiente stock de accesorios. Si no, se cancela la orden
(defrule validar-stock-accesorios
    (declare (salience 10)) ; Ejecutar antes de las reglas normales
    ?orden <- (orden (id ?idorden) (tipoproducto 3) (idproducto ?idproducto) (idcliente ?idcliente) (cantidad ?cantidad))
    ?accesorio <- (accesorio (idproducto ?idproducto) (stock ?stock) (nombre ?nombreaccesorio))
    (cliente (id ?idcliente) (nombre ?n))
    (not (ordenprocesada ?idorden)) ; Evitar que se procese la misma orden varias veces
    =>
    (if (< ?stock ?cantidad) then
        (retract ?orden) ; Eliminar la orden si no hay stock
        (printout t ?n ", no hay suficiente stock para el accesorio '" ?nombreaccesorio "'. La orden con id " ?idorden " ha sido cancelada. Stock restante: " ?stock "." crlf)
    )
)

;? REGLAS DE OFERTAS Y DESCUENTOS (SE EJECUTAN DESPUÉS DE LAS REGLAS DE VALIDACIÓN Y ACTUALIZACIÓN DE STOCK)
; 7) En la compra de un iPhone 16 con tarjetas banamex, ofrece 24 meses sin intereses
(defrule ofrecer-meses-iphone16
    (orden (tipoproducto 1) (idproducto 2) (tarjeta banamex) (idcliente ?id))
    (cliente (id ?id) (nombre ?n))
    (not (orden-ofrecer-meses ?id)) ; Evitar que se procese la misma orden varias veces
    =>
    (assert (orden-ofrecer-meses ?id)) ; Marcar la orden como procesada
    (printout t ?n ", te ofrecemos 24 meses sin intereses en tu compra de un iPhone 16 con tarjeta banamex." crlf)
)

; 8) En la compra de un Samsung S21 con tarjeta liverpool visa, ofrece 12 meses sin intereses
(defrule ofrecer-meses-samsung21
    (orden (tipoproducto 1) (idproducto 1) (tarjeta liverpool) (idcliente ?id))
    (cliente (id ?id) (nombre ?n))
    (not (orden-ofrecer-meses ?id)) ; Evitar que se procese la misma orden varias veces
    =>
    (assert (orden-ofrecer-meses ?id)) ; Marcar la orden como procesada
    (printout t ?n ", te ofrecemos 12 meses sin intereses en tu compra de Samsung S21 con tarjeta liverpool visa." crlf)
)

; 9) En la compra al contado de una ThinkPad X1 Carbon y un iPhone 16, ofrece 100 pesos en vales por cada 1000 pesos de compra
(defrule ofrecer-vale-thinkpad-iphone16
    ; Compra de thinkpad
    (orden (id ?idorden) (tipoproducto 2) (idproducto 3) (tarjeta contado) (idcliente ?id) (cantidad ?cantthink))
    ; Compra de iphone
    (orden (id ?idorden2) (tipoproducto 1) (idproducto 2) (tarjeta contado) (idcliente ?id) (cantidad ?cantiphone))
    ; Producto thinkpad
    (computadora (idproducto 3) (precio ?p1))
    ; Producto iphone
    (celular (idproducto 2) (precio ?p2))
    (cliente (id ?id) (nombre ?n))
    ; Evitar que se procese la misma orden varias veces
    (not (and (orden-vale-thinkpad-iphone16 ?idorden) (orden-vale-thinkpad-iphone16 ?idorden2)))
    =>
    ; Calcular el total de la compra
    (bind ?total (+ (* ?p1 ?cantthink) (* ?p2 ?cantiphone)))
    ; Comprobar si el total es mayor a 1000
    (if (>= ?total 1000) then
        ; Calcular el total de vales
        ; div sirve para obtener solo la parte entera
        (bind ?vales (div ?total 1000))
        (assert (orden-vale-thinkpad-iphone16 ?idorden)) ; Marcar la orden como procesada
        (assert (orden-vale-thinkpad-iphone16 ?idorden2)) ; Marcar la orden como procesada
        ; Crear el vale
        (assert (vale (idcliente ?id) (valor (* ?vales 100)) (texto ?n ", te ofrecemos " ?vales " vales de 100 pesos ($"(* ?vales 100)") por tu compra de " ?total " pesos. ¡Utilízalos cuando desees!")))
        ; Mostrar el mensaje
        (printout t ?n ", te ofrecemos " ?vales " vales de 100 pesos ($"(* ?vales 100)") por tu compra de " ?total " pesos. ¡Utilízalos cuando desees!" crlf)
    )
)

; 10) Si el cliente compra un celular, ofrece una funda y mica con un 15% de descuento sobre accesorios
(defrule ofrecer-accesorios-celular
    (orden (id ?idorden) (tipoproducto 1) (idproducto ?idproducto) (idcliente ?id))
    (cliente (id ?id) (nombre ?n))
    (celular (marca ?marca) (modelo ?modelo) (idproducto ?idproducto))
    (not (orden-ofrecer-accesorios ?idorden)) ; Evitar que se procese la misma orden varias veces
    =>
    (assert (orden-ofrecer-accesorios ?idorden)) ; Marcar la orden como procesada
    (printout t ?n ", te ofrecemos una funda y mica con un 15% de descuento sobre accesorios por la compra de tu celular " ?marca " " ?modelo "." crlf)
)

; 11) Detectar si un cliente es minorista o mayorista < 10, > 10 en celulares
(defrule detectar-cliente-minorista-mayorista-celular
    (orden (id ?idorden) (tipoproducto 1) (idproducto ?idproducto) (idcliente ?idcliente) (cantidad ?cantidad))
    (cliente (id ?idcliente) (nombre ?nombre))
    ; Se comprueba que se tenga el suficiente stock, por si esto se ejecuta antes de la regla de stock
    (celular (idproducto ?idproducto) (marca ?marca) (modelo ?modelo))
    (not (ordensegmentada ?idorden)) ; Evitar que se procese la misma orden varias veces
    =>
    (assert (ordensegmentada ?idorden)) ; Marcar la orden como procesada
    ; Imprimir mensaje de cliente minorista o mayorista < 10 o >= 10
    (printout t ?nombre " compró " ?cantidad " " ?marca " " ?modelo ", es un cliente " (if (< ?cantidad 10) then "MINORISTA" else "MAYORISTA") "." crlf)
)

; 12) Detectar si un cliente es minorista o mayorista < 10, > 10 en computadoras
(defrule detectar-cliente-minorista-mayorista-computadora
    (orden (id ?idorden) (tipoproducto 2) (idproducto ?idproducto) (idcliente ?idcliente) (cantidad ?cantidad))
    (cliente (id ?idcliente) (nombre ?nombre))
    (computadora (idproducto ?idproducto) (marca ?marca) (modelo ?modelo))
    (not (ordensegmentada ?idorden)) ; Evitar que se procese la misma orden varias veces
    =>
    (assert (ordensegmentada ?idorden)) ; Marcar la orden como procesada
    ; Imprimir mensaje de cliente minorista o mayorista < 10 o >= 10
    (printout t ?nombre " compró " ?cantidad " " ?marca " " ?modelo ", es un cliente " (if (< ?cantidad 10) then "MINORISTA" else "MAYORISTA") "." crlf)
)

; 13) Detectar si un cliente es minorista o mayorista < 10, > 10 en accesorios
(defrule detectar-cliente-minorista-mayorista-accesorio
    (orden (id ?idorden) (tipoproducto 3) (idproducto ?idproducto) (idcliente ?idcliente) (cantidad ?cantidad) (tarjeta ?tarjeta&:(neq ?tarjeta gratis)))
    (cliente (id ?idcliente) (nombre ?nombre))
    (accesorio (idproducto ?idproducto) (nombre ?nombreaccesorio))
    (not (ordensegmentada ?idorden)) ; Evitar que se procese la misma orden varias veces
    =>
    (assert (ordensegmentada ?idorden)) ; Marcar la orden como procesada
    ; Imprimir mensaje de cliente minorista o mayorista < 10 o >= 10
    (printout t ?nombre " compró " ?cantidad " " ?nombreaccesorio ", es un cliente " (if (< ?cantidad 10) then "MINORISTA" else "MAYORISTA") "." crlf)
)

; 14) Ofrecer un descuento del 10% en la compra actual si se piden 10 celulares o más y el cliente tiene una tarjeta BBVA
(defrule ofrecer-descuento-celulares-bbva
    (orden (tipoproducto 1) (idproducto ?idproducto) (tarjeta bbva) (idcliente ?id) (cantidad ?cantidad&:(>= ?cantidad 10)))
    (celular (idproducto ?idproducto) (precio ?precio))
    (cliente (id ?id) (nombre ?n))
    (not (orden-descuento-celulares-bbva ?id)) ; Evitar que se procese la misma orden varias veces
    =>
    (bind ?total (* ?precio ?cantidad)) ; Calcular el total sin descuento
    (bind ?descuento (* ?total 0.1)) ; Calcular el descuento
    (bind ?preciofinal (- ?total ?descuento)) ; Calcular el precio final
    (assert (orden-descuento-celulares-bbva ?id)) ; Marcar la orden como procesada
    (printout t ?n ", se te descontó el 10% ($" ?descuento ") del total por tu compra de 10 celulares o más con BBVA. Paga $" ?preciofinal " en lugar de $" ?total crlf)
)

; 15) Ofrecer 5% de cashback en la compra de un accesorio si el cliente paga con una tarjeta Nu
(defrule ofrecer-cashback-accesorio-nu
    (orden (tipoproducto 3) (idproducto ?idproducto) (tarjeta nu) (idcliente ?id) (cantidad ?cantidad))
    (accesorio (idproducto ?idproducto) (precio ?precio))
    (cliente (id ?id) (nombre ?n))
    (not (orden-cashback-accesorio-nu ?id)) ; Evitar que se procese la misma orden varias veces
    =>
    (bind ?total (* ?precio ?cantidad)) ; Calcular el total sin descuento
    (bind ?cashback (* ?total 0.05)) ; Calcular el cashback
    (assert (orden-cashback-accesorio-nu ?id)) ; Marcar la orden como procesada
    (printout t ?n ", se te ha reembolsado un 5% de cashback ($" ?cashback ") por tu compra de un accesorio con tarjeta Nu." crlf)
)

; 16) Ofrecer un vale de 200 pesos por cada computadora Asus ZenBook 14 pagada al contado
(defrule ofrecer-vale-computadora-zenbook14
    ; Orden de computadora
    (orden (id ?idorden) (tipoproducto 2) (idproducto 4) (tarjeta contado) (idcliente ?id) (cantidad ?cantidad))
    (cliente (id ?id) (nombre ?n))
    ; Producto computadora
    (computadora (idproducto 4) (precio ?precio))
    ; Evitar que se procese la misma orden varias veces
    (not (orden-vale-zenbook ?idorden))
    =>
    ; Calcular el total de la compra
    (bind ?total (* ?precio ?cantidad))
    (assert (orden-vale-zenbook ?idorden)) ; Marcar la orden como procesada
    ; Crear los vales
    (assert (vale (idcliente ?id) (valor (* ?cantidad 200)) (texto ?n ", te ofrecemos " ?cantidad " vales de 200 pesos ($"(* ?cantidad 200)") por tu compra de " ?total " pesos. ¡Utilízalos cuando desees!")))
    ; Mostrar el mensaje
    (printout t ?n ", te ofrecemos " ?cantidad " vales de 200 pesos ($"(* ?cantidad 200)") por tu compra de " ?cantidad " Asus ZenBook 14. ¡Utilízalos cuando desees!" crlf)
)

; 17) Regalar audifonos con la compra de un Xiami Mi 11 (crear una orden y en tarjeta poner gratis)
; En la regla de disminuir stock se toma en cuenta cuando es gratis para mandar otro mensaje (no se hace lo mismo con los demás tipos de productos porque nunca se regalan)
(defrule regalar-audifonos-xiaomi
    (orden (tipoproducto 1) (idproducto 3) (idcliente ?id))
    (cliente (id ?id) (nombre ?nombre))
    ; Evitar que se procese la misma orden varias veces
    (not (orden-regalo-audifonos-xiaomi ?id))
    =>
    (assert (orden-regalo-audifonos-xiaomi ?id)) ; Marcar la orden como procesada
    ; Crear el hecho de regalo
    (assert (orden (tipoproducto 3) (idproducto 4) (idcliente ?id) (tarjeta gratis) (cantidad 1)))
    ; Mostrar el mensaje
    (printout t ?nombre ", te regalamos unos audifonos con tu compra de un Xiaomi Mi 11." crlf)
)

; 18) Regalar una USB con la compra de una HP Spectre x360 (crear una orden y en tarjeta poner gratis)
(defrule regalar-usb-spectre360
    (orden (tipoproducto 2) (idproducto 2) (idcliente ?id))
    (cliente (id ?id) (nombre ?nombre))
    ; Evitar que se procese la misma orden varias veces
    (not (orden-regalo-usb-xiaomi ?id))
    =>
    (assert (orden-regalo-usb-xiaomi ?id)) ; Marcar la orden como procesada
    ; Crear el hecho de regalo
    (assert (orden (tipoproducto 3) (idproducto 5) (idcliente ?id) (tarjeta gratis) (cantidad 1)))
    ; Mostrar el mensaje
    (printout t ?nombre ", te regalamos una USB con tu compra de una computadora HP Spectre x360." crlf)
)

; 19) Regalar un cargador con la compra de un Samsung Galaxy S23 (crear una orden y en tarjeta poner gratis)
(defrule regalar-cargador-samsungs23
    (orden (tipoproducto 1) (idproducto 6) (idcliente ?id))
    (cliente (id ?id) (nombre ?nombre))
    ; Evitar que se procese la misma orden varias veces
    (not (orden-regalo-cargador-samsungs23 ?id))
    =>
    (assert (orden-regalo-cargador-samsungs23 ?id)) ; Marcar la orden como procesada
    ; Crear el hecho de regalo
    (assert (orden (tipoproducto 3) (idproducto 2) (idcliente ?id) (tarjeta gratis) (cantidad 1)))
    ; Mostrar el mensaje
    (printout t ?nombre ", te regalamos un cargador con tu compra de un Samsung Galaxy S23." crlf)
)

; 20) Regalar una licencia de office (1 mes) en la compra de una laptop (Dell XPS 13) si el cliente es menor de edad
(defrule ofrecer-office-laptop-estudiante
    (orden (id ?idorden) (tipoproducto 2) (idproducto 1) (idcliente ?id))
    (cliente (id ?id) (nombre ?n) (edad ?edad&:(< ?edad 18)))
    (computadora (marca ?marca) (modelo ?modelo) (idproducto 1))
    (not (orden-ofrecer-office ?idorden)) ; Evitar que se procese la misma orden varias veces
    =>
    (assert (orden-ofrecer-office ?idorden)) ; Marcar la orden como procesada
    ; Crear el hecho de regalo
    (assert (orden (tipoproducto 3) (idproducto 6) (idcliente ?id) (tarjeta gratis) (cantidad 1)))
    (printout t ?n ", te ofrecemos una licencia de office (1 mes) por la compra de tu laptop " ?marca " " ?modelo "." crlf)
)