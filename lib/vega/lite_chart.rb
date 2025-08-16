module Vega
  class LiteChart < BaseChart
    # https://vega.github.io/vega-lite/docs/spec.html
    scalar_methods \
      :background, :padding, :autosize, :title, :name, :description, :width, :height, :mark, :spec, :repeat

    hash_methods \
      :config, :usermeta, :projection, :datasets, :encoding, :facet, :resolve, :selection, :view

    array_methods \
      :transform, :layer, :hconcat, :vconcat, :concat, :params

    def initialize
      @schema = "https://vega.github.io/schema/vega-lite/v6.json"
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

    def to_png
      export("vl2png")
    end

    def to_svg
      export("vl2svg")
    end

    def to_pdf
      export("vl2pdf")
    end
  end
end
