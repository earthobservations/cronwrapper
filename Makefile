default: all

all:
	python setup.py build

install: all
	python setup.py install

clean:
	rm -f *.pyc
	cd tests && rm -f *.pyc
	cd cronwrapper && rm -f *.pyc
	cd tests && rm -Rf htmlcov 
	rm -f .coverage tests/.coverage
	rm -f MANIFEST
	rm -Rf build
	rm -Rf dist
	rm -Rf cronwrapper.egg-info
	rm -Rf cronwrapper/__pycache__
	rm -Rf tests/__pycache__
	rm -f tests/conf.py
	rm -f tests/auth.txt

sdist: clean
	python setup.py sdist

test:
	flake8 .
	cd tests && nosetests

coveralls:
	cd tests && nosetests --with-coverage --cover-package=cronwrapper && ../.coveralls.sh

upload:
	python setup.py sdist register upload

coverage:
	cd tests && coverage run `which nosetests` && coverage html --include='*/cronwrapper/*' --omit='test_*'

release: test coverage clean upload clean 
