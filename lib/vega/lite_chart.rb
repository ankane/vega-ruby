module Vega
  class LiteChart < BaseChart
    # https://vega.github.io/vega-lite/docs/spec.html
    scalar_methods \
      :background, :padding, :autosize, :title, :name, :description, :width, :height, :mark, :spec

    hash_methods \
      :config, :usermeta, :projection, :datasets, :encoding, :repeat, :resolve, :selection

    array_methods \
      :transform, :layer, :hconcat, :vconcat

    def initialize
      @schema = "https://vega.github.io/schema/vega-lite/v4.json"
      super()
    end

    def data!(value)
      @spec[:data] = data_value(value)
      self
    end
    immutable_method :data
  end
end
