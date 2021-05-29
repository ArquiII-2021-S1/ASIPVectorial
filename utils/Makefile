all: generateMif

generateMif:
	python3 imageUtils.py -i "$(SOURCE)"

displayResult:
	python3 imageUtils.py --show
help:
	@echo "\n"
	@echo "Ejecutar \033[96m make SOURCE=\"IMAGEPATH\" \033[0m para crear los archivos mif de cada canal de la imagen"
	@echo "Ejemplo \033[96m make SOURCE=./input/test.png \033[0m "
	@echo "\n"
	@echo "Para mostrar el resultado, ejecutar el comando \033[96m make displayResult \033[0m"
	@echo "\n"
