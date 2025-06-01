# Project: cpp
# Makefile created by Steve Chang
# Date modified: 2025.06.01
# MAKEFLAGS += --trace
GCC_PATH := $(shell which gcc)
$(info [make] Using GCC from: $(GCC_PATH))
# $(info [make] MSYSTEM: $(MSYSTEM))
# $(info [make] GCC: $(shell pacman -Qe | grep gcc))
# $(info [make] MSYS2: $(shell pacman -Qe | grep msys))
# $(info [make] GCC Version: $(shell pacman -Qe | grep gcc | awk '{print $$2}'))
# $(info [make] MSYS2 Version: $(shell pacman -Qe | grep msys | awk '{print $$2}'))

PROJDIR = $(CURDIR)
SRCDIR 	= $(PROJDIR)/src
LIBDIR	= $(PROJDIR)/lib
BINDIR 	= $(PROJDIR)/bin

SUBDIR = \
	src \

COMMON_INCLUDE = \
	$(CURDIR)/include \

_BINNAME = cpp

ifeq ($(OS),Windows_NT)
    OSFLAG += -DWIN32
    ifeq ($(PROCESSOR_ARCHITEW6432),AMD64)
        OSFLAG += -DAMD64
		BINNAME = $(_BINNAME).exe
    else
        ifeq ($(PROCESSOR_ARCHITECTURE),AMD64)
            OSFLAG += -DAMD64
			BINNAME = $(_BINNAME).exe
        endif
        ifeq ($(PROCESSOR_ARCHITECTURE),x86)
            OSFLAG += -DIA32
			BINNAME = $(_BINNAME).exe
        endif
    endif
else
    UNAME_S := $(shell uname -s)
    ifeq ($(UNAME_S),Linux)
        OSFLAG += -DLINUX
		BINNAME = $(_BINNAME)
    endif
    ifeq ($(UNAME_S),Darwin)
        OSFLAG += -DOSX
		BINNAME = $(_BINNAME)
    endif
    UNAME_P := $(shell uname -p)
    ifeq ($(UNAME_P),x86_64)
        OSFLAG += -DAMD64
		BINNAME = $(_BINNAME)
    endif
    ifneq ($(filter %86,$(UNAME_P)),)
        OSFLAG += -DIA32
		BINNAME = $(_BINNAME)
    endif
    ifneq ($(filter arm%,$(UNAME_P)),)
        OSFLAG += -DARM
		BINNAME = $(_BINNAME)
    endif
endif

# CC = gcc
CC = g++
AR = ar
LD = ld

MAKE_RULES := $(PROJDIR)/make/make_rules.mk

# Extra flags to give to compilers when they are supposed to invoke the linker,
# `ld`, such as -L. Libraries (-lfoo) should be added to the LDLIBS variable
# instead.
LDFLAGS = \
	$(addprefix -L,$(EXTERN_LIBDIR)) \
	$(addprefix -L,$(LIBDIR)) \
	# -v \
	# -static \
	# -static-libgcc \

# Library flags or names given to compilers when they are supposed to invoke
# the linker, `ld`. LOADLIBES is a deprecated (but still supported) alternative to
# LDLIBS. Non-library linker flags, such as -L, should go in the LDFLAGS variable.
LIBS = \
	main \

LDLIBS = $(foreach lib,$(LIBS),-l$(lib)) -lm # -lpthread	# <-- Do not change this order.

export BINNAME
export PROJDIR
export SRCDIR
export LIBDIR
export BINDIR
export COMMON_INCLUDE
export EXTERN_LIBDIR
export EXTERN_INCLUDE
export CC AR
export MAKE_RULES
export OSFLAG

.PHONY: all
all:
	@echo $(OSFLAG)
	mkdir -p $(BINDIR)
	mkdir -p $(LIBDIR)
	for dir in $(SUBDIR); do \
		cd $$dir; \
		# make -j $@; \
		make $@; \
		cd $(CURDIR); \
	done
	$(CC) $(LDFLAGS) $(LDLIBS) -o $(BINDIR)/$(BINNAME)

.PHONY: clean
clean:
	rm -f $(BINDIR)/$(BINNAME)
	rm -f $(LIBDIR)/*
	for dir in $(SUBDIR); do \
		cd $$dir; \
		make -j $@; \
		cd $(CURDIR); \
	done

.PHONY: objall
objall:
	for dir in $(SUBDIR); do \
		cd $$dir; \
		make -j $@; \
		cd $(CURDIR); \
	done

.PHONY: objclean
objclean:
	for dir in $(SUBDIR); do \
		cd $$dir; \
		make -j $@; \
		cd $(CURDIR); \
	done

.PHONY: asmall
asmall:
	for dir in $(SUBDIR); do \
		cd $$dir; \
		make -j $@; \
		cd $(CURDIR); \
	done

.PHONY: asmclean
asmclean:
	for dir in $(SUBDIR); do \
		cd $$dir; \
		make -j $@; \
		cd $(CURDIR); \
	done

.PHONY: depall
depall:
	for dir in $(SUBDIR); do \
		cd $$dir; \
		make -j $@; \
		cd $(CURDIR); \
	done

.PHONY: depclean
depclean:
	for dir in $(SUBDIR); do \
		cd $$dir; \
		make -j $@; \
		cd $(CURDIR); \
	done

.PHONY: format
format:
	$(CURDIR)/Astyle/bin/astyle.exe --options=$(CURDIR)/_astylerc -I -R ./*.cpp,*.c,*.h --exclude=AStyle --formatted
