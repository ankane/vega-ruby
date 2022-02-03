require_relative "test_helper"

class HelperTest < Minitest::Test
  include Vega::Helper

  def test_works
    assert_match "vegaEmbed", vega_chart(Vega.lite)
  end

  def test_bad_type
    error = assert_raises(TypeError) do
      vega_chart Object.new
    end
    assert_equal "expected Vega chart", error.message
  end
end
