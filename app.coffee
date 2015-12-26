feathers = require 'feathers'
nedb = require 'feathers-nedb'
memory = nedb 'values'

# {
#   db: 'edermempy'
#   collection: 'values'
#     #host: process.env.DB_URL
#     #username: 'edersantana'
#     #password: process.env.DB_PASS
#     #port: 53190
# }

bodyParser = require 'body-parser'
app = feathers()

app.configure feathers.rest()
  .configure feathers.socketio()
  .use bodyParser.json()
  .use '/api/v1/values', memory
  .use '/', feathers.static(__dirname)
  .listen 3000

console.log 'App listening on port 3000, actually'
console.log 'Index at', __dirname+'/static/'
