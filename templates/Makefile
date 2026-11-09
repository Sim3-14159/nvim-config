.PHONY: all clean configure
.DEFAULT_GOAL := all

CC := gcc
CFLAGS = -O2
NAME = 


all: configure
	mkdir -p build
	cd build
	$(CC) $(CFLAGS) main.c -o $(NAME)

configure:
	@echo "Configuring project"

clean:
	rm -rf build/
