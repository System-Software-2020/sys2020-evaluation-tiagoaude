CC = gcc
CFLAGS = -Wall -g -std=c99 -m32
LD = gcc
LDFLAGS = -m32
AR = gcc
ARFLAGS = -shared -m32
INCLUDE = lib
LIB = lib
SRC = src
BIN = bin

all: libex2.so ex1 $(BIN)

ex1: $(BIN)/ex1.o libex2.so
	$(LD) -o $@ $^ $(LDFLAGS) -L.

$(BIN)/ex1.o: $(SRC)/ex1.c
	$(CC) -c -o $@ $< $(CFLAGS) -I$(INCLUDE)

libex2.so: $(BIN)/ex2.o
	$(AR) $(ARFLAGS) -o $@ $^

$(BIN)/ex2.o: $(LIB)/ex2.c $(LIB)/ex2.h $(BIN)
	$(CC) -c -o $@ $< $(CFLAGS) -I$(INCLUDE) -fPIC

$(BIN):
	mkdir $@

install: libex2.so $(LIB)/ex2.h ex1
	cp libex2.so $(prefix)/usr/lib/.
	cp $(LIB)/ex2.h $(prefix)/usr/include/.
	cp ex1 $(prefix)/usr/bin/.

uninstall:
	rm -f $(prefix)/usr/lib/libex2.so
	rm -f $(prefix)/usr/include/ex2.h
	rm -f $(prefix)/usr/bin/ex1

clean:
	rm -f libex2.so ex1 $(BIN)/*

run:
	./ex1