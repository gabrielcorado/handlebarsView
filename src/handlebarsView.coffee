# View Class
class window.View
  # Init
  constructor: (@name, template) ->
    @source = $("[data-template-name=\"#{template}\"]").text()
    @template = Handlebars.compile @source

  # Clear the view
  clear: ->
    @location = $ "[data-render-template=\"#{@name}\"]"
    @location.html ''

  # Build view
  build: (data = {}) ->
    @location = $ "[data-render-template=\"#{@name}\"]"
    template = new Handlebars.SafeString @template(data)
    template

  render: (data = {}) ->
    built = @build data
    @location.html built.string
    return true

  append: (data = {}) ->
    built = @build data
    @location.append built.string
    return true
