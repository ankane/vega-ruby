require_relative "test_helper"

class ExportTest < Minitest::Test
  def setup
    skip unless ENV["TEST_EXPORT"]
  end

  def test_to_png
    assert_match "\x89PNG".b, chart.to_png
  end

  def test_to_svg
    assert_match "<svg", chart.to_svg
  end

  def test_to_pdf
    assert_match "%PDF", chart.to_pdf
  end

  def test_error
    error = assert_raises do
      Vega.start.to_png
    end
    # unfortunately, error message not helpful
    assert_match "Command failed", error.message
  end

  def test_lite_to_png
    assert_match "\x89PNG".b, lite_chart.to_png
  end

  def test_lite_to_svg
    assert_match "<svg", lite_chart.to_svg
  end

  def test_lite_to_pdf
    assert_match "%PDF", lite_chart.to_pdf
  end

  def test_lite_error
    error = assert_raises do
      Vega.lite.to_png
    end
    assert_match "Invalid specification", error.message
  end

  def chart
    Vega.start.width(100).height(100)
  end

  def lite_chart
    Vega.lite.mark("bar")
  end
end
