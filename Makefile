INPUT ?= src/cv/index.tex
OUTPUT ?= $(shell basename "$(shell dirname "$(INPUT)")")
DOCKER_COMPOSE = docker-compose
UP = ${DOCKER_COMPOSE} up
OUTPUT_DIRECTORY = build
LATEXMK_ARGS ?= -halt-on-error -MP -logfilewarninglist -pdf -shell-escape -interaction=nonstopmode -file-line-error -output-directory=$(OUTPUT_DIRECTORY)
DOCKER_TEXINPUTS = "/home/src//:"
TEXINPUTS = "$(shell pwd)/src//:"

DOCKER_TEXLIVE_RUN = ${DOCKER_COMPOSE} run -e TEXINPUTS=$(DOCKER_TEXINPUTS) texlive
DOCKER_PANDOC_RUN = ${DOCKER_COMPOSE} run pandoc
DOCKER_PLANTUML_RUN = ${DOCKER_COMPOSE} run plantuml
DOCKER_CONVERT_RUN = ${DOCKER_COMPOSE} run convert
DOCKER_LATEXMK_COMMAND = $(DOCKER_TEXLIVE_RUN) latexmk $(LATEXMK_ARGS)

TEXLIVE_RUN = TEXINPUTS=$(TEXINPUTS)
PANDOC_RUN = pandoc
PLANTUML_RUN = plantuml
CONVERT_RUN = convert
LATEXMK_COMMAND = $(TEXLIVE_RUN) latexmk $(LATEXMK_ARGS)

# Make does not offer a recursive wildcard function, so here's one:
rwildcard=$(wildcard $1$2) $(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2))

.PHONY: build view

cv : build

%:
	$(MAKE) build INPUT=src/$@/index.tex

build :
	$(LATEXMK_COMMAND) -jobname=$(OUTPUT) $(INPUT)
	$(MAKE) chmodbuild

docker-build :
	$(DOCKER_LATEXMK_COMMAND) -jobname=$(OUTPUT) $(INPUT)
	$(MAKE) chmodbuild

plantuml :
	$(PLANTUML_RUN) -tsvg src/presentation/resources/*.plantuml

docker-plantuml :
	$(DOCKER_PLANTUML_RUN) -tsvg src/presentation/resources/*.plantuml

pandoc :
	$(PANDOC_RUN) -s $(INPUT) -o $(OUTPUT)

docker-pandoc :
	$(DOCKER_PANDOC_RUN) -s $(INPUT) -o $(OUTPUT)

docker-convert :
	$(DOCKER_CONVERT_RUN) -density 1200 $(INPUT) $(OUTPUT)

latexindent :
	$(TEXLIVE_RUN) latexindent

docker-latexindent :
	$(DOCKER_TEXLIVE_RUN) latexindent

clean :
	rm -rf build

docker-clean :
	$(DOCKER_TEXLIVE_RUN) rm -rf build

docker-lint :
	$(foreach file, $(call rwildcard,$(shell dirname "$(INPUT)"),*.tex), $(DOCKER_TEXLIVE_RUN) lacheck $(file);)
	$(foreach file, $(call rwildcard,$(shell dirname "$(INPUT)"),*.tex), $(DOCKER_TEXLIVE_RUN) chktex $(file);)
	$(foreach file, $(call rwildcard,$(shell dirname "$(INPUT)"),*.tex), $(DOCKER_TEXLIVE_RUN) latexindent $(file);)

lint :
	$(foreach file, $(call rwildcard,$(shell dirname "$(INPUT)"),*.tex), lacheck $(file);)
	$(foreach file, $(call rwildcard,$(shell dirname "$(INPUT)"),*.tex), chktex $(file);)
	$(foreach file, $(call rwildcard,$(shell dirname "$(INPUT)"),*.tex), latexindent $(file);)

chmodbuild:
	$(TEXLIVE_RUN) chmod 777 build

watch:
	$(LATEXMK_COMMAND) -pvc -jobname=$(OUTPUT) $(INPUT)
	$(MAKE) chmodbuild

docker-watch:
	$(DOCKER_LATEXMK_COMMAND) -pvc -jobname=$(OUTPUT) $(INPUT)
	$(MAKE) chmodbuild

fresh:
	$(MAKE) chmodbuild clean build

buildall:
	$(MAKE) clean
	$(foreach file, $(wildcard src/**/index.tex), $(MAKE) build INPUT=$(file);)
