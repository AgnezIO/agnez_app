feathers = require 'feathers'
nedb = require 'feathers-nedb'
memory = nedb 'values'

bodyParser = require 'body-parser'
app = feathers()

app.configure feathers.rest()
  .configure feathers.socketio()
  .use bodyParser.json({limit: '50mb'})
  .use '/api/v1/values', memory
  .use '/', feathers.static(__dirname)
  .listen 3000

console.log 'App listening on port 3000'
console.log 'Index at', __dirname+'/static/'
