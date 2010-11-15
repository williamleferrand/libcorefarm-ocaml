 #
 #
 #  This file is part of Corefarm-OCaml/Ocsigen
 #
 #  Corefarm-OCaml/Ocsigen is free software: you can redistribute it and/or modify
 #  it under the terms of the GNU General Public License as published by
 #  the Free Software Foundation, either version 3 of the License, or
 #  (at your option) any later 
 #  
 #  Corefarm-OCaml/Ocsigen is distributed in the hope that it will be useful,
 #  but WITHOUT ANY WARRANTY; without even the implied warranty of
 #  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 #  GNU General Public License for more details.
 #  
 #  You should have received a copy of the GNU General Public License
 #  along with Corefarm-OCaml/Ocsigen. If not, see <http://www.gnu.org/licenses/>.
 #
 #  Makefile william le ferrand (william@corefarm.com) 02/07/2010 20:26
 #
 #

all:
	ocamlbuild corefarm_ocsigen.cma

install:
	ocamlfind install corefarm_ocsigen META _build/corefarm_ocsigen.cma _build/corefarm_ocsigen.cmi 

remove: 
	ocamlfind remove corefarm_ocsigen

clean:
	ocamlbuild -clean


test:test.ml
	ocamlfind ocamlc -package cryptokit $^ -o $@ -linkpkg