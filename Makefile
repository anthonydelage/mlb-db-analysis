.PHONY: venv

venv: requirements.txt
	@virtualenv venv -p python3
	@source venv/bin/activate && pip install -r requirements.txt
