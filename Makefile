JS=./js

.PHONY : all clean watch

all: node_modules $(JS)/scripts.js

clean:
	rm -f $(JS)/*.js
	rm -rf node_modules

clean_db:
	rm -rf db-data

$(JS)/scripts.js:
	coffee -c $(JS)/*.coffee

node_modules:
	npm install

watch:
	coffee -wc $(JS)/*.coffee

run:
	coffee app.coffee

restart: clean_db run
