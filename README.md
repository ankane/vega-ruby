# Vega.rb

Interactive charts for Ruby, powered by [Vega](https://vega.github.io/vega/) and [Vega-Lite](https://vega.github.io/vega-lite/)

Works with Rails, iRuby, and other frameworks

[![Build Status](https://travis-ci.org/ankane/vega.svg?branch=master)](https://travis-ci.org/ankane/vega)

## Installation

Add this line to your application’s Gemfile:

```ruby
gem 'vega'
```

The follow the instructions for how you plan to use it:

- [Rails 6 / Webpacker](#rails-6--webpacker)
- [Rails 5 / Sprockets](#rails-5--sprockets)
- [iRuby](#iruby)
- [Other](#other)

### Rails 6 / Webpacker

Run:

```sh
yarn add vega vega-lite vega-embed
```

And add to `app/javascript/packs/application.js`:

```js
window.vegaEmbed = require("vega-embed").default
```

### Rails 5 / Sprockets

Add to `app/assets/javascripts/application.js`:

```js
//= require vega
//= require vega-lite
//= require vega-embed
```

### iRuby

No additional set up is needed.

### Other

For Sinatra and other web frameworks, include the Vega JavaScript files on pages with charts:

```html
<script src="https://cdn.jsdelivr.net/npm/vega@5.16.1"></script>
<script src="https://cdn.jsdelivr.net/npm/vega-lite@4.16.2"></script>
<script src="https://cdn.jsdelivr.net/npm/vega-embed@6.12.2"></script>
```

## Getting Started

Vega is a visualization grammar, and Vega-Lite is a high-level grammar built on top of it. We recommend using Vega-Lite by default and moving to Vega for advanced use cases.

Create visualizations by chaining together methods:

```ruby
Vega.lite.data(data).mark("bar").height(200)
```

There are methods for each of the top-level properties. The docs are a great source of examples:

- [Vega-Lite docs](https://vega.github.io/vega-lite/docs/)
- [Vega docs](https://vega.github.io/vega/docs/)

## Example

Create a bar chart

```ruby
Vega.lite
  .data(
    values: [
      {a: "A", b: 28},
      {a: "B", b: 55},
      {a: "C", b: 43},
      {a: "D", b: 91},
      {a: "E", b: 81},
      {a: "F", b: 53},
      {a: "G", b: 19},
      {a: "H", b: 87},
      {a: "I", b: 52}
    ]
  )
  .mark(type: "bar", tooltip: true)
  .encoding(
    x: {field: "a", type: "ordinal"},
    y: {field: "b", type: "quantitative"}
  )
```

The chart will automatically render in iRuby. For Rails, render it in your view:

```erb
<%= Vega.lite.data(...) %>
```

## Vega-Lite

Start a Vega-Lite chart with:

```ruby
Vega.lite
```

### Data

[Docs](https://vega.github.io/vega-lite/docs/data.html)

The data source can be an array

```ruby
data(values: [{x: "A", y: 1}, {x: "B", y: 2}])
```

Or a URL

```ruby
data(url: "https://www.example.com")
```

You can also specify the data format

```ruby
data(url: "https://www.example.com/data.csv", format: {type: "csv"})
```

### Transforms

[Docs](https://vega.github.io/vega-lite/docs/transform.html)

```ruby
transform(bin: true, field: "a", as: "binned a")
```

### Marks

[Docs](https://vega.github.io/vega-lite/docs/mark.html)

Bar chart

```ruby
mark("bar")
```

Line chart

```ruby
mark("line")
```

Pie chart

```ruby
mark("pie")
```

Area chart

```ruby
mark("area")
```

Enable tooltips

```ruby
mark(type: "bar", tooltip: true)
```

### Encoding

[Docs](https://vega.github.io/vega-lite/docs/mark.html)

```ruby
encoding(x: {field: "a", type: "ordinal"})
```

### Projection

[Docs](https://vega.github.io/vega-lite/docs/projection.html)

```ruby
projection(type: "albersUsa")
```

### Configuration

[Docs](https://vega.github.io/vega-lite/docs/config.html)

Set the font

```ruby
config(font: "Helvetica")
```

### Top-Level Properties

[Docs](https://vega.github.io/vega-lite/docs/spec.html#top-level)

Set width and height

```ruby
width(500).height(300)
```

Set the background color

```ruby
background("#000")
```

Set padding

```ruby
padding(5)
# or
padding(left: 5, top: 5, right: 5, bottom: 5)
```

### Embed Options

[Docs](https://github.com/vega/vega-embed#options)

Set embed options

```ruby
embed_options(actions: true)
```

## Vega

You can also use Vega directly. In this case, you don’t need to include Vega-Lite in the JavaScript files.

Start a Vega chart with:

```ruby
Vega.start
```

## Spec

You can also create a specification by hand

```ruby
spec = {
  "$schema" => "https://vega.github.io/schema/vega-lite/v4.json",
  "data" => {"url" => "https://www.example.com"},
  # ...
}
```

And render it in Rails

```erb
<%= Vega.render(spec) %>
```

Or display it in iRuby

```ruby
Vega.display(spec)
```

Get the spec for a chart

```ruby
chart.spec
```

## History

View the [changelog](https://github.com/ankane/vega/blob/master/CHANGELOG.md)

## Contributing

Everyone is encouraged to help improve this project. Here are a few ways you can help:

- [Report bugs](https://github.com/ankane/vega/issues)
- Fix bugs and [submit pull requests](https://github.com/ankane/vega/pulls)
- Write, clarify, or fix documentation
- Suggest or add new features

To get started with development:

```sh
git clone https://github.com/ankane/vega.git
cd vega
bundle install
bundle exec rake test
```

Resources for contributors:

- [Vega specification](https://vega.github.io/vega/docs/specification/)
- [Vega-Lite specification](https://vega.github.io/vega-lite/docs/spec.html)
