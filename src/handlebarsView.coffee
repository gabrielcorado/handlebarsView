# View Class
class window.View
  # Init
  constructor: (@name, template, @options = {  }) ->
    # Source
    @source = $("[data-template-name=\"#{template}\"]").text()

    # Template location
    @location = $ "[data-render-template=\"#{@name}\"]"

    # The template function
    @template = Handlebars.compile @source

  # Generate a MD5 key based on data
  _dataKey: (data) ->
    CryptoJS.MD5(JSON.stringify(data)).toString()

  # Clear the view
  clear: ->
    @location.html ''

  # Build view
  build: (data = {  }, options = {  }) ->
    # Generate the key
    dataKey = @_dataKey data

    # Build the template
    templateGeneration = new Handlebars.SafeString(@template(data)).string

    # Add a container div
    if @options.key
      # Default values
      options.container or= {  }
      options.container.classes or= ''
      options.container.extras or= ''

      # Interpolate it
      templateGeneration = "<div class=\"handlebars-view #{options.container.classes}\" data-view-key=\"#{dataKey}\" #{options.container.extras}>#{templateGeneration}</div>"

    # Return
    return templateGeneration

  # Render the template on @location
  render: (data = {  }, options = {  }) ->
    # Built template
    template = @build data, options

    # Render it
    @location.html template

    # Default return
    return true

  # Append the template on @location
  append: (data = {  }, options = {  }) ->
    # Built template
    template = @build data, options

    # Appedn it
    @location.append template

    # Default return
    return true
