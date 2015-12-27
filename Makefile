JS=./js

.PHONY : all clean watch

all: node_modules script.js 

clean:
	rm -f $(JS)/*.js
	rm -rf node_modules

clean_db:
	rm -rf db-data

scripts.js:
	coffee -c $(JS)/*.coffee

node_modules:
	npm install

watch:
	coffee -wc $(JS)/*.coffee

run:
	coffee app.coffee
