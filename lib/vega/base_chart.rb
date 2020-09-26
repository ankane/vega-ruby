module Vega
  class BaseChart
    extend MethodHelpers

    def initialize
      @spec = {
        "$schema": @schema,
        width: "container",
        height: "container"
        # maybe add later
        # config: {mark: {tooltip: true}}
      }
    end

    def embed_options!(value)
      usermeta!(embedOptions: value)
      self
    end
    immutable_method :embed_options

    def to_s
      Spec.new(spec).to_s
    end

    def to_iruby
      Spec.new(spec).to_iruby
    end

    private

    def initialize_dup(*)
      # dup one-level up
      @spec = @spec.transform_values(&:dup)
      super
    end

    def data_value(value)
      value = value.to_a if defined?(Rover::DataFrame) && value.is_a?(Rover::DataFrame)
      value = value.to_a[0] if defined?(Daru::DataFrame) && value.is_a?(Daru::DataFrame)
      case value
      when Array
        {values: value}
      when String
        {url: value}
      else
        value
      end
    end
  end
end
