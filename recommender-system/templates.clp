(deftemplate celular
    (slot marca)
    (slot modelo)
    (slot precio)
    (slot color)
)

(deftemplate computadora
    (slot marca)
    (slot modelo)
    (slot precio)
    (slot color)
)

(deftemplate tarjeta
    (slot banco)
    (slot grupo)
    (slot fecha-exp)
)

(deftemplate accesorio
    (slot nombre)
    (slot precio)
)

(deftemplate cliente
    (slot id)
    (slot nombre)
    (slot edad)
)

(deftemplate orden
    (slot id)
    (slot idproducto)
    (slot idcliente)
    (slot cantidad)
)

(deftemplate vale
    (slot texto)
)
