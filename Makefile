JS=./js 

.PHONY : all clean watch

all: node_modules script.js 

clean:
	rm -f $(JS)/*.js
	rm -f node_modules

script.js:
	coffee -c $(JS)/*.coffee

node_modules:
	npm install

watch:
	coffee -wc $(JS)/*.coffee
