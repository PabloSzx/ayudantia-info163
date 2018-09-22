all:
	mkdir -p compilador/obj/${a}
	$(MAKE) exactly || $(MAKE) folder || $(MAKE) print
exactly:
	./compilador/pfc2 ${a} -o compilador/obj/${a}.obj
	./compilador/pfc2int compilador/obj/${a}
	$(MAKE) clear
folder:
	./compilador/pfc2 ${a}/${a} -o compilador/obj/${a}/${a}.obj
	./compilador/pfc2int compilador/obj/${a}/${a}
	$(MAKE) clear
clear:
	rm -rf compilador/obj/*
print:
	## Para usar este compilador escriba: make a=nombre_archivo
	## Puede darle como argumento tanto una direccion exacta al .pfc
	## O el nombre de una carpeta si dentro de esa carpeta tiene el .pfc dentro con el mismo nombre
	## Puede probar con el ejemplo incluido escribiendo: make a=barbero
	## Cabe mencionar que sus programas deben terminar con la extension .pfc

