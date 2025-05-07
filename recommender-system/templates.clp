(deftemplate celular
    (slot tipoproducto)
    (slot idproducto)
    (slot marca)
    (slot modelo)
    (slot precio)
    (slot color)
    (slot stock)
)

(deftemplate computadora
    (slot tipoproducto)
    (slot idproducto)
    (slot marca)
    (slot modelo)
    (slot precio)
    (slot color)
    (slot stock)
)

(deftemplate accesorio
    (slot tipoproducto)
    (slot idproducto)
    (slot nombre)
    (slot precio)
    (slot stock)
)

(deftemplate tarjeta
    (slot banco)
    (slot grupo)
    (slot fecha-exp)
)

(deftemplate cliente
    (slot id)
    (slot nombre)
    (slot edad)
)

(deftemplate orden
    (slot id (default-dynamic (gensym*)))
    (slot tipoproducto)
    (slot idproducto)
    (slot idcliente)
    (slot tarjeta)
    (slot cantidad)
)

(deftemplate vale
    (slot id (default-dynamic (gensym*)))
    (slot idcliente)
    (slot valor)
    (multislot texto)
)
