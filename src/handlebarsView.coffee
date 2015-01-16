# Dependencies
unless CryptoJS.MD5 || jQuery || Handlebars
  throw 'check the list of dependence'

# View Class
class View
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

  # Get items and order by view position
  _getItems: ->
    @location.find('[data-view-position]').toArray().sort (a, b) ->
      # Positions
      aPosition = Number $(a).attr('data-view-position') if a
      bPosition = Number $(b).attr('data-view-position') if b

      return 0 unless b || a

      # Return
      return a > b ? 1 : -1

  _findPrevItem: (position) ->
    # Item
    item = undefined

    # Get items
    items = @_getItems()

    # each items
    for eItem in items
      # Item
      el = $ eItem

      # item position
      elPosition = Number el.attr('data-view-position')

      if elPosition > position
        item = { el: el, distance: position - elPosition }
        break

      # sub position
      position--

    # Return the item
    item

  _findNextItem: (position) ->
    # Item
    item = undefined

    # Get items
    items = @_getItems()

    # each items
    for eItem in items
      # Item
      el = $ eItem

      # item position
      elPosition = Number el.attr('data-view-position')

      if elPosition < position
        item = { el: el, distance: elPosition - position }
        break

      # Add position
      position++

    # Return the item
    item

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
    if @options.keys
      # Default values
      options.container or= {  }
      options.container.classes or= ''
      options.container.extras or= ''
      options.container.el or= 'div'

      # Set position
      options.position or= ''

      # Interpolate it
      templateGeneration = "
        <#{options.container.el} class=\"handlebars-view #{options.container.classes}\" data-view-key=\"#{dataKey}\" data-view-position=\"#{options.position}\" #{options.container.extras}>
          #{templateGeneration}
        </#{options.container.el}>
      "

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
    # Checks position exists
    if options.position? && isNaN options.position
      throw 'position must be a number'

    # Built template
    template = @build data, options

    # Check position rule
    if options.position?
      # Transform position in number
      options.position = Number options.position

      # Get last and prev items
      prevItem = @_findPrevItem options.position
      nextItem = @_findNextItem options.position

      # Checks around item exists
      if nextItem && nextItem.distance < prevItem.distance
        nextItem.el.after template
      else if prevItem
        prevItem.el.before template
      else
        @location.append template

    else
      # Append it
      @location.append template

    # Default return
    return true

# Set it global
window.View or= View
