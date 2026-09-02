PYTHON ?= python3
DOCTOR_VENV ?= .venv
DOCTOR_PYTHON := $(DOCTOR_VENV)/bin/python
DOCTOR_INSTALL_MARKER := $(DOCTOR_VENV)/.urirun-runtime-installed

.PHONY: install doctor-build doctor-test doctor-health test check

$(DOCTOR_INSTALL_MARKER): pyproject.toml
	$(PYTHON) -m venv $(DOCTOR_VENV)
	$(DOCTOR_PYTHON) -m pip install .
	touch $(DOCTOR_INSTALL_MARKER)

install: $(DOCTOR_INSTALL_MARKER)

doctor-build:
	$(PYTHON) -c "import pathlib, tomllib; data = tomllib.loads(pathlib.Path('pyproject.toml').read_text()); assert data['tool']['setuptools']['packages'] == []"

doctor-test: $(DOCTOR_INSTALL_MARKER)
	$(DOCTOR_PYTHON) -c "import importlib.metadata as metadata; assert metadata.version('urirun-runtime')"

doctor-health: $(DOCTOR_INSTALL_MARKER)
	$(DOCTOR_PYTHON) -c "import urirun_runtime"

test: doctor-test

check: doctor-build doctor-test doctor-health
