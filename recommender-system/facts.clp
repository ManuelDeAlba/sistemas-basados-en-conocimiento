(deffacts celulares
    (celular (tipoproducto 1) (idproducto 1) (marca "Samsung") (modelo "Galaxy S21") (precio 799) (color negro) (stock 50))
    (celular (tipoproducto 1) (idproducto 2) (marca "Apple") (modelo "iPhone 13") (precio 999) (color blanco) (stock 30))
    (celular (tipoproducto 1) (idproducto 3) (marca "Xiaomi") (modelo "Mi 11") (precio 749) (color rojo) (stock 20))
    (celular (tipoproducto 1) (idproducto 4) (marca "OnePlus") (modelo "9 Pro") (precio 969) (color azul) (stock 15))
    (celular (tipoproducto 1) (idproducto 5) (marca "Google") (modelo "Pixel 6") (precio 599) (color amarillo) (stock 25))
)

(deffacts computadoras
    (computadora (tipoproducto 2) (idproducto 1) (marca "Dell") (modelo "XPS 13") (precio 999) (color negro) (stock 10))
    (computadora (tipoproducto 2) (idproducto 2) (marca "HP") (modelo "Spectre x360") (precio 1199) (color negro) (stock 5))
    (computadora (tipoproducto 2) (idproducto 3) (marca "Lenovo") (modelo "ThinkPad X1 Carbon") (precio 1399) (color gris) (stock 8))
)

(deffacts accesorios
    (accesorio (tipoproducto 3) (idproducto 1) (nombre Funda) (precio 15) (stock 20))
    (accesorio (tipoproducto 3) (idproducto 2) (nombre Cargador) (precio 30) (stock 15))
    (accesorio (tipoproducto 3) (idproducto 3) (nombre Mica) (precio 5) (stock 20))
)

(deffacts tarjetas
    (tarjeta (banco BBVA) (grupo visa) (fecha-exp 12/25))
    (tarjeta (banco NU) (grupo mastercard) (fecha-exp 12/27))
    (tarjeta (banco Santander mastercard) (grupo VISA) (fecha-exp 12/25))
)

(deffacts clientes
    (cliente (id 1) (nombre Manuel) (edad 21))
    (cliente (id 2) (nombre Daniela) (edad 26))
    (cliente (id 3) (nombre Itzel) (edad 20))
    (cliente (id 4) (nombre Leonardo) (edad 15))
    (cliente (id 1) (nombre Naomi) (edad 15))
)

(deffacts ordenes
    (orden (id 1) (tipoproducto 1) (idproducto 1) (idcliente 1) (cantidad 1))
    (orden (id 2) (tipoproducto 2) (idproducto 3) (idcliente 2) (cantidad 2))
    (orden (id 3) (tipoproducto 3) (idproducto 2) (idcliente 3) (cantidad 4))
)

(deffacts vales
    (vale (id 1) (idcliente 1) (texto "Felicidades, has ganado un vale de descuento del 10% en tu próxima compra."))
    (vale (id 2) (idcliente 2) (texto "Felicidades, has ganado un vale de descuento del 15% en tu próxima compra."))
)
