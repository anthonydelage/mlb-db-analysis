.PHONY: clean, venv, all

clean:
	rm -rf .venv

sync:
	uv sync

all: clean sync
