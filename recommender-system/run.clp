; (batch "run.clp")

(clear)

(reset)

(batch "templates.clp")

(batch "facts.clp")

(batch "rules.clp")

(reset)

(assert (orden (id 1) (tipoproducto 1) (idproducto 2) (idcliente 1) (tarjeta banamex) (cantidad 2))) ; Celular | iPhone 16 | Manuel | banamex | 1
(run)
----------------------------------------

(assert (orden (id 2) (tipoproducto 1) (idproducto 2) (idcliente 1) (tarjeta contado) (cantidad 1))) ; Celular | iPhone 16 | Manuel | contado | 1
(run)
----------------------------------------

(assert (orden (id 3) (tipoproducto 2) (idproducto 3) (idcliente 2) (tarjeta banamex) (cantidad 2))) ; Computadora | ThinkPad X1 Carbon | Daniela | banamex | 2
(run)
----------------------------------------

(assert (orden (id 4) (tipoproducto 1) (idproducto 1) (idcliente 3) (tarjeta liverpool) (cantidad 1))) ; Celular | Samsung S21 | Itzel | liverpool | 1
(run)
----------------------------------------

(assert (orden (id 5) (tipoproducto 2) (idproducto 3) (idcliente 1) (tarjeta contado) (cantidad 3))) ; Computadora | ThinkPad X1 Carbon | Manuel | contado | 3
(run)
----------------------------------------

(assert (orden (id 6) (tipoproducto 1) (idproducto 1) (idcliente 1) (tarjeta nu) (cantidad 999))) ; Celular | Samsung S21 | Manuel | nu | 999
(run)
----------------------------------------

(assert (orden (id 7) (tipoproducto 2) (idproducto 1) (idcliente 1) (tarjeta nu) (cantidad 999))) ; Computadora | Dell XPS 13 | Manuel | nu | 999
(run)
----------------------------------------

(assert (orden (id 8) (tipoproducto 3) (idproducto 1) (idcliente 4) (tarjeta nu) (cantidad 999))) ; Accesorio | Funda | Leonardo | nu | 999
(run)
----------------------------------------

(assert (orden (id 9) (tipoproducto 3) (idproducto 1) (idcliente 4) (tarjeta nu) (cantidad 1))) ; Accesorio | Funda | Leonardo | nu | 1
(run)
----------------------------------------

(assert (orden (id 10) (tipoproducto 1) (idproducto 5) (idcliente 5) (tarjeta bbva) (cantidad 10))) ; Celular | Pixel 6 | Naomi | bbva | 10
(run)
----------------------------------------

(assert (orden (id 11) (tipoproducto 3) (idproducto 2) (idcliente 5) (tarjeta nu) (cantidad 1))) ; Accesorio | Cargador | Naomi | nu | 1
(run)
----------------------------------------

(assert (orden (id 12) (tipoproducto 2) (idproducto 4) (idcliente 2) (tarjeta contado) (cantidad 2))) ; Computadora | ZenBook 14 | Daniela | contado | 2
(run)
----------------------------------------

(assert (orden (id 13) (tipoproducto 1) (idproducto 4) (idcliente 2) (tarjeta nu) (cantidad 1))) ; Celular | OnePlus 9 Pro | Daniela | nu | 1
(run)
----------------------------------------

(assert (orden (id 14) (tipoproducto 1) (idproducto 3) (idcliente 2) (tarjeta nu) (cantidad 1))) ; Celular | Mi 11 | Daniela | nu | 1
(run)
----------------------------------------

(assert (orden (id 15) (tipoproducto 2) (idproducto 2) (idcliente 1) (tarjeta nu) (cantidad 1))) ; Computadora | Spectre x360 | Daniela | nu | 1
(run)
----------------------------------------

(assert (orden (id 16) (tipoproducto 1) (idproducto 6) (idcliente 1) (tarjeta nu) (cantidad 1))) ; Celular | Galaxy S23 | Manuel | nu | 1
(run)
----------------------------------------

(assert (orden (id 17) (tipoproducto 2) (idproducto 1) (idcliente 5) (tarjeta contado) (cantidad 1))) ; Computadora | Dell XPS 13 | Naomi | contado | 1
(run)
----------------------------------------
