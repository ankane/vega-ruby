module Vega
  class Chart < BaseChart
    # https://vega.github.io/vega/docs/specification/
    scalar_methods \
      :description, :background, :width, :height,
      :padding, :autosize, :title, :encode

    hash_methods \
      :config, :usermeta

    array_methods \
      :signals, :scales, :projections, :axes, :legends, :marks

    attr_reader :spec

    def initialize
      @schema = "https://vega.github.io/schema/vega/v6.json"
      super()
    end

    def data!(value)
      (@spec[:data] ||= []) << data_value(value)
      self
    end
    immutable_method :data

    def to_png
      export("vg2png")
    end

    def to_svg
      export("vg2svg")
    end

    def to_pdf
      export("vg2pdf")
    end
  end
end
