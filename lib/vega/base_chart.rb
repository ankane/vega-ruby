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

    # for https://github.com/SciRuby/iruby/issues/314
    def to_iruby_mimebundle(**)
      [[to_iruby].to_h, nil]
    end

    def to_json
      spec.to_json
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

    def export(cmd)
      require "open3"

      pkg = cmd.start_with?("vg") ? "vega-cli" : "vega-lite"
      # use --no to prevent automatic installs
      stdout, stderr, status = Open3.capture3("npm", "exec", "--no", "--package=#{pkg}", "--", cmd, stdin_data: to_json, binmode: true)
      raise "Command failed: #{stderr}" unless status.success? && stdout.bytesize > 0
      stdout
    end
  end
end
