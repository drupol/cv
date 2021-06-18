INPUT ?= src/sample/index.tex
OUTPUT ?= $(shell basename "$(shell dirname "$(INPUT)")")
DOCKER_COMPOSE = docker-compose
UP = ${DOCKER_COMPOSE} up
OUTPUT_DIRECTORY = build
LATEXMK_ARGS ?= -halt-on-error -MP -logfilewarninglist -pdf -shell-escape -interaction=nonstopmode -file-line-error -output-directory=$(OUTPUT_DIRECTORY)
TEXINPUTS = "/home/src//:"
TEXLIVE_RUN = ${DOCKER_COMPOSE} run -e TEXINPUTS=$(TEXINPUTS) texlive
PANDOC_RUN = ${DOCKER_COMPOSE} run pandoc
LATEXMK_COMMAND = $(TEXLIVE_RUN) latexmk $(LATEXMK_ARGS)

# Make does not offer a recursive wildcard function, so here's one:
rwildcard=$(wildcard $1$2) $(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2))

.PHONY: build view

all : build

%:
	$(MAKE) build INPUT=src/$@/index.tex

build :
	$(LATEXMK_COMMAND) -jobname=$(OUTPUT) $(INPUT)
	$(MAKE) chmodbuild

pandoc :
	$(PANDOC_RUN) -s $(INPUT) -o $(OUTPUT)

latexindent :
	$(TEXLIVE_RUN) latexindent

clean :
	$(TEXLIVE_RUN) rm -rf build

lint :
	$(foreach file, $(call rwildcard,$(shell dirname "$(INPUT)"),*.tex), $(TEXLIVE_RUN) lacheck $(file);)
	$(foreach file, $(call rwildcard,$(shell dirname "$(INPUT)"),*.tex), $(TEXLIVE_RUN) chktex $(file);)
	$(foreach file, $(call rwildcard,$(shell dirname "$(INPUT)"),*.tex), $(TEXLIVE_RUN) latexindent $(file);)

chmodbuild:
	$(TEXLIVE_RUN) chmod 777 build

watch:
	$(LATEXMK_COMMAND) -pvc -jobname=$(OUTPUT) $(INPUT)
	$(MAKE) chmodbuild

fresh:
	$(MAKE) chmodbuild clean build

buildall:
	$(MAKE) clean
	$(foreach file, $(wildcard src/**/index.tex), $(MAKE) build INPUT=$(file);)
