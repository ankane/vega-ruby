# stdlib
require "erb"
require "json"
require "securerandom"

# modules
require_relative "vega/method_helpers"
require_relative "vega/base_chart"
require_relative "vega/chart"
require_relative "vega/lite_chart"
require_relative "vega/spec"
require_relative "vega/helper"
require_relative "vega/version"

# integrations
require_relative "vega/engine" if defined?(Rails)

module Vega
  class << self
    # save chart method for now
    def start
      Chart.new
    end

    def lite
      LiteChart.new
    end

    def render(spec, nonce: nil)
      Spec.new(spec).to_html(nonce: nonce)
    end

    def display(spec)
      IRuby.display(Spec.new(spec))
    end
  end
end

if defined?(ActiveSupport.on_load)
  ActiveSupport.on_load(:action_view) do
    include Vega::Helper
  end
end
