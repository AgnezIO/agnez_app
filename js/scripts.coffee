# Real time REST tools
socket = io()
app = feathers().configure feathers.socketio socket
values = app.service '/api/v1/values'

# We need to add a new Bootstrap row after every two new cells.
cell_count = 0

# Add Python inspired `format` method to String 
# This way "dat {0} is {1}".format("string", "cool") == "dat string is cool"
# source: http://stackoverflow.com/questions/9880578/coffeescript-version-of-string-format-sprintf-etc-for-javascript-or-node-js
String.prototype.format = ->
  args = arguments
  return this.replace /{(\d+)}/g, (match, number) ->
    return if typeof args[number] isnt 'undefined' then args[number] else match

# Dashboard cell
# format arguments:
# {0}: title (string)
# {1}: position (int)
# {2}: cell html (string)
# {3}: description (string)
cellstr = """
  <div class="col-sm-6">
    <div class="chart-wrapper">
      <div class="chart-title" id=title{1}>
        {0} 
      </div>
      <div class="chart-stage" id="grid{1}">
        {2} 
      </div>
      <div class="chart-notes" id="description{1}">
        {3} 
      </div>
    </div>
  </div>
"""

# feathers CRUD callbacks
values.on 'patched', (val) ->
  console.log 'patching', val.name
  $grid = $ "#grid#{val.pos}"
  $title = $ "#title#{val.pos}"
  $description = $ "#description#{val.pos}"

  $title.html val.name
  $description.html val.description
  if val.type is "html"
    $grid.html val.value
  if val.type is "img"
    $grid.html "<img src='#{val.value}'>"

  $grid.height "400px"

values.on 'created', (val) ->
  console.log 'creating', val.name
  addValue(val)

# CREATE callback
addValue = (val) ->
  $dash = $ "#dashboard"
  if cell_count %% 2 == 0
    $dash.append '<div class="row"></div>'

  # Get last row
  $row = $ ".row:last"
  console.log "Adding value #{val.id}"
  console.log "value type #{val.type}"

  if val.type is "img"
    img_scr = "<img src='#{val.value}'>"
    thisstr = cellstr.format val.name, val.pos, img_scr, val.description
    $row.append thisstr
    cell_count += 1

  if val.type is "html"
    thisstr = cellstr.format val.name, val.pos, val.value, val.description
    $row.append thisstr
    cell_count += 1

# Render all values already on the database
values.find (error, values) ->
  values.forEach addValue
