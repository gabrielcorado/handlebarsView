# HandleBars View

## Table of contents
* [Usage](#usage)
* [API](#api)
* [Checklist](#checklies)
* [Dependencies](#dependencies)

## Usage

For this tutorial i'll use this smaple data:

**Menu items:**

```javascript
// Menu
var menuItems = [
  { title: 'Github', url: 'http://github.com/', position: 3 },
  { title: 'Handlebars', url: 'http://handlebarsjs.com/', position: 1 },
  { title: 'NPM', url: 'http://npmjs.com/', position: 5 },
  { title: 'jQuery', url: 'http://jquery.com/', position: 4 },
  { title: 'Google', url: 'http://google.com', position: 2 }
];
```

Start with your view, first define where the template will be rendered

```html
<nav class="main-menu">
  <ul class="menu-items" data-render-template="menuItem">

  </ul>
</nav>
```

after that, create the template

```html
<script type="text/x-handlebars" data-template-name="menuItem">
  <a href="{{url}}">{{title}}</a>
</script>
```

and then

```javascript
// Define view
var menuItemView = new View('menuItem', 'menuItem', { keys: true });

// Clear the view container(render-template)
menuItemView.clear();

// Append some data
for( var i = 0; i < menuItems.length; i++ ) {
  menuItemView.append(
    menuItems[i],
    {
      position: menuItems[i].position,
      container: {
        el: 'li',
        classes: 'menu-item'
      }
    }
  );
}
```

## Checklist
* [x] ~~Simple view system~~
* [x] ~~View positions~~
* [x] ~~Only append if it's necessary~~
* [ ] Only render if it's necessary
* [ ] Collection helper to have positions and keys in the handlebars template
* [ ] Render helper using the view method
* [ ] Cache views? Who knows
* [ ] Views Events (rendered, built, ...)
* [ ] Delegate events to the view (like click on links)

## API

### new View(name, template, options = {  }, handlebars = View.ENV)

Create a view with specific name, the template can be shared with others views but the name don't.

### View.clear()

Clear the HTML of location element.

### View.build(data = {  }, options = {  })

Build the handlebars template with the data and the options.

### View.render(data = {  }, options = {  })

Override the location html with the result of view.

### View.append(data = {  }, options = {  })

Append the build in the location element.

## Dependencies

* JSON
* Handlebars
* jQuery
* Crypto-JS(MD5)
