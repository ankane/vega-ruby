require_relative "test_helper"

class HelperTest < Minitest::Test
  include Vega::Helper

  def test_works
    assert_match "vegaEmbed", vega_chart(Vega.lite)
  end

  def test_nonce
    stub(:content_security_policy_nonce, "test123") do
      assert_match '<script nonce="test123">', vega_chart(Vega.lite)
    end
  end

  def test_nonce_not_configured
    refute_match "nonce", vega_chart(Vega.lite)
  end

  def test_bad_type
    error = assert_raises(TypeError) do
      vega_chart Object.new
    end
    assert_equal "expected Vega chart", error.message
  end

  # for stubbing
  def content_security_policy_nonce
    nil
  end
end
