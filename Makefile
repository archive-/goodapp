CC=g++
FLAGS=-O3 -Werror

.PHONY: all clean

all: scripts/trust.cpp
	$(CC) $(FLAGS) -o bin/trust scripts/trust.cpp

clean: bin/trust
	rm -f bin/trust
