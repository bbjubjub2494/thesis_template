name=report

.PHONY: lint

$(name).pdf: lint
	rubber --pdf $(name).tex

lint:
	lacheck $(name).tex

clean:
	rubber --clean --pdf $(name).tex
