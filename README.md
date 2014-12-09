# HandleBars View

## Usage

First define the root element for all the views.

```javascript
View.root = $('.page-content');
```

And start with your view, first define where the template will be rendered

```html
<div data-render-template="wishList"></div>
```

after that, create the template

```html
<script type="text/x-handlebars" data-template-name="list">
  <h1>{{listName}}</h1>

  <ul>
    {{#each content}}
      <li><strong>{{name}}:</strong> {{value}}</li>
    {{/each}}
  </ul>
</script>
```

and then

```javascript
// Define view
var wishListView = new View('wishList', 'list');

// Render some data
wishListView.render(
  {
    listName: 'Wish List',
    content: [
      { name: 'JS', value: 'JavaScript' },
      { name: 'RB', value: 'Ruby' },
    ]
  }
);

// Clear the view
wishListView.clear();

// You can append some data too
wishListView.append(
  {
    listName: 'Dog - Wish List',
    content: [
      { name: 'Food', value: 'I\'m hungry' },
      { name: 'Ball', value: 'I want to play' },
    ]
  }
);

wishListView.append(
  {
    listName: 'Cat - Wish List',
    content: [
    { name: 'Food', value: 'I\'m hungry' },
    { name: 'Ball', value: 'That\'s right' },
    ]
  }
);
```

## API

### View.clear()

Clear the HTML of location element.

### View.build(data = {})

Build the handlebars template with the data.

### View.render(data = {})

Override the location html with the result of view.

### View.append(data = {})

Append the build in the location element.

## Requires

* Handlebars
* jQuery
