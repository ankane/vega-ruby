# Vega.rb

Interactive charts for Ruby, powered by [Vega](https://vega.github.io/vega/) and [Vega-Lite](https://vega.github.io/vega-lite/)

[See it in action](https://vega.dokkuapp.com)

Works with Rails, iRuby, and other frameworks

[![Build Status](https://github.com/ankane/vega-ruby/workflows/build/badge.svg?branch=master)](https://github.com/ankane/vega-ruby/actions)

## Installation

Add this line to your application’s Gemfile:

```ruby
gem "vega"
```

Then follow the instructions for how you plan to use it:

- [Rails 7 / Importmap](#rails-7--importmap)
- [Rails 7 / esbuild or Webpack](#rails-7--esbuild-or-webpack)
- [Rails 6 / Webpacker](#rails-6--webpacker)
- [Rails 5 / Sprockets](#rails-5--sprockets)
- [iRuby](#iruby)
- [Other](#other)

### Rails 7 / Importmap

Add to `config/importmap.rb`:

```ruby
pin "vega", to: "vega.js"
pin "vega-lite", to: "vega-lite.js"
pin "vega-embed", to: "vega-embed.js"
```

And add to `app/javascript/application.js`:

```js
import "vega"
import "vega-lite"
import "vega-embed"

window.dispatchEvent(new Event("vega:load"))
```

### Rails 7 / esbuild or Webpack

Run:

```sh
yarn add vega vega-lite vega-embed
```

And add to `app/javascript/application.js`:

```js
import embed from "vega-embed"

window.vegaEmbed = embed
window.dispatchEvent(new Event("vega:load"))
```

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

For Sinatra and other web frameworks, download [Vega](https://cdn.jsdelivr.net/npm/vega@5), [Vega-Lite](https://cdn.jsdelivr.net/npm/vega-lite@5), and [Vega-Embed](https://cdn.jsdelivr.net/npm/vega-embed@6) and include them on pages with charts:

```html
<script src="vega.js"></script>
<script src="vega-lite.js"></script>
<script src="vega-embed.js"></script>
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
  .data([{city: "A", sales: 28}, {city: "B", sales: 55}, {city: "C", sales: 43}])
  .mark(type: "bar", tooltip: true)
  .encoding(
    x: {field: "city", type: "nominal"},
    y: {field: "sales", type: "quantitative"}
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

Data can be an array

```ruby
data([{x: "A", y: 1}, {x: "B", y: 2}])
```

Or a URL

```ruby
data("https://www.example.com/data.json")
```

Or a Rover data frame

```ruby
data(df)
```

Or a data generator

```ruby
data(sequence: {start: 0, stop: 10, step: 1, as: "x"})
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

### View Composition

[Docs](https://vega.github.io/vega-lite/docs/composition.html)

Faceting

```ruby
facet(row: {field: "x"})
```

Layering

```ruby
layer(view)
```

Concatenation

```ruby
hconcat(view)
vconcat(view)
concat(view)
```

Repeating

```ruby
repeat(row: ["a", "b", "c"])
```

Resolving

```ruby
resolve(scale: {color: "independent"})
```

### Selections

[Docs](https://vega.github.io/vega-lite/docs/selection.html)

```ruby
selection(x: {type: "single"})
```

### Config

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
  "$schema" => "https://vega.github.io/schema/vega-lite/v5.json",
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

## Exporting Charts (experimental)

Export charts to PNG, SVG, or PDF. This requires Node.js and npm 7+. Run:

```sh
yarn add vega-cli vega-lite
```

For PNG, use:

```ruby
File.binwrite("chart.png", chart.to_png)
```

For SVG, use:

```ruby
File.binwrite("chart.svg", chart.to_svg)
```

For PDF, use:

```ruby
File.binwrite("chart.pdf", chart.to_pdf)
```

## Content Security Policy (CSP)

By default, the Vega parser uses the Function constructor, which [can cause issues with CSP](https://vega.github.io/vega/usage/interpreter/).

For Rails 7 / Importmap, add to `config/importmap.rb`:

```ruby
pin "vega-interpreter", to: "vega-interpreter.js"
```

And add to `app/javascript/application.js`:

```js
import "vega-interpreter"
```

For Rails 6 / Webpacker, run:

```sh
yarn add vega-interpreter
```

For Rails 5 / Sprockets, add to `app/assets/javascripts/application.js`:

```js
//= require vega-interpreter
```

And set embed options for your charts

```ruby
embed_options(ast: true)
```

## History

View the [changelog](https://github.com/ankane/vega-ruby/blob/master/CHANGELOG.md)

## Contributing

Everyone is encouraged to help improve this project. Here are a few ways you can help:

- [Report bugs](https://github.com/ankane/vega-ruby/issues)
- Fix bugs and [submit pull requests](https://github.com/ankane/vega-ruby/pulls)
- Write, clarify, or fix documentation
- Suggest or add new features

To get started with development:

```sh
git clone https://github.com/ankane/vega-ruby.git
cd vega-ruby
bundle install
bundle exec rake test
```

Resources for contributors:

- [Vega specification](https://vega.github.io/vega/docs/specification/)
- [Vega-Lite specification](https://vega.github.io/vega-lite/docs/spec.html)
