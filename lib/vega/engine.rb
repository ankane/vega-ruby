module Vega
  class Engine < ::Rails::Engine
    # for assets

    # for importmap
    initializer "vega.importmap" do |app|
      if app.config.respond_to?(:assets) && defined?(Importmap) && defined?(Sprockets)
        app.config.assets.precompile << "vega-embed.js"
        app.config.assets.precompile << "vega-interpreter.js"
        app.config.assets.precompile << "vega-lite.js"
        app.config.assets.precompile << "vega.js"
      end
    end
  end
end
