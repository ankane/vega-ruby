require_relative "test_helper"

class HelperTest < Minitest::Test
  include Vega::Helper

  def test_chart
    assert_match "vegaEmbed", vega_chart(Vega.lite)
  end

  def test_spec
    assert_match "vegaEmbed", vega_chart(Vega.lite.spec)
  end

  def test_nonce_chart
    with_nonce do
      assert_match '<script nonce="test123">', vega_chart(Vega.lite)
    end
    refute_match "nonce", vega_chart(Vega.lite, nonce: false)
  end

  def test_nonce_spec
    with_nonce do
      assert_match '<script nonce="test123">', vega_chart(Vega.lite.spec)
    end
  end

  def test_nonce_not_configured
    refute_match "nonce", vega_chart(Vega.lite)
    refute_match "nonce", vega_chart(Vega.lite.spec)
  end

  def test_nonce_false
    with_nonce do
      refute_match "nonce", vega_chart(Vega.lite, nonce: false)
    end
  end

  def test_bad_type
    error = assert_raises(TypeError) do
      vega_chart Object.new
    end
    assert_equal "expected Vega chart or spec", error.message
  end

  def with_nonce
    stub(:content_security_policy_nonce, "test123") do
      yield
    end
  end

  # for stubbing
  def content_security_policy_nonce
    nil
  end
end
