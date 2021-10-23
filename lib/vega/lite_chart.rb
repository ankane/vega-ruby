module Vega
  class LiteChart < BaseChart
    # https://vega.github.io/vega-lite/docs/spec.html
    scalar_methods \
      :background, :padding, :autosize, :title, :name, :description, :width, :height, :mark, :spec, :repeat

    hash_methods \
      :config, :usermeta, :projection, :datasets, :encoding, :facet, :resolve, :selection, :view

    array_methods \
      :transform, :layer, :hconcat, :vconcat, :concat

    def initialize
      @schema = "https://vega.github.io/schema/vega-lite/v5.json"
      super()
    end

    def data!(value)
      @spec[:data] = data_value(value)
      self
    end
    immutable_method :data

    undef spec
    def spec(*args)
      if args.empty?
        @spec
      else
        dup.spec!(*args)
      end
    end
  end
end
