.PHONY: clean, venv, all

clean:
	rm -rf venv

venv/bin/activate: requirements.txt
	test -d venv || virtualenv venv -p python3
	venv/bin/pip install -Ur requirements.txt
	. venv/bin/activate

venv: venv/bin/activate

all: clean venv
