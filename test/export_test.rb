require_relative "test_helper"

class ExportTest < Minitest::Test
  def setup
    skip unless ENV["TEST_EXPORT"]
  end

  def test_to_png
    # TODO
  end

  def test_to_svg
    # TODO
  end

  def test_to_pdf
    # TODO
  end

  def test_error
    error = assert_raises do
      Vega.start.to_png
    end
    # unfortunately, error message not helpful
    assert_match "Command failed", error.message
  end

  def test_lite_to_png
    assert_match "\x89PNG".b, Vega.lite.mark("bar").to_png
  end

  def test_lite_to_svg
    assert_match "<svg", Vega.lite.mark("bar").to_svg
  end

  def test_lite_to_pdf
    assert_match "%PDF".b, Vega.lite.mark("bar").to_pdf
  end

  def test_lite_error
    error = assert_raises do
      Vega.lite.to_png
    end
    assert_match "Invalid specification", error.message
  end
end
