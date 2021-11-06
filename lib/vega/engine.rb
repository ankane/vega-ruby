module Vega
  class Engine < ::Rails::Engine
    # for assets

    # for importmap
    if defined?(Importmap)
      initializer "vega.importmap", after: "importmap" do |app|
        app.config.assets.precompile << "vega-embed.js"
        app.config.assets.precompile << "vega-interpreter.js"
        app.config.assets.precompile << "vega-lite.js"
        app.config.assets.precompile << "vega.js"
      end
    end
  end
end
