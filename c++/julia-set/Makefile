
run: build
	./JULIA > juila-image.ppm

build: juliaSet.cpp juliaSet.h colorTable.cpp colorTable.h ppm.h ppm.cpp  main.cpp
	g++ -o JULIA juliaSet.cpp colorTable.cpp ppm.cpp  main.cpp


