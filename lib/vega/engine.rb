module Vega
  class Engine < ::Rails::Engine
    # for assets

    # for importmap
    initializer "vega.importmap" do |app|
      if defined?(Importmap)
        app.config.assets.precompile << "vega-embed.js"
        app.config.assets.precompile << "vega-interpreter.js"
        app.config.assets.precompile << "vega-lite.js"
        app.config.assets.precompile << "vega.js"
      end
    end
  end
end
