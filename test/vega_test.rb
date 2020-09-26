require_relative "test_helper"

class VegaTest < Minitest::Test
  def test_data_inline
    values = [{x: "A", y: 1}, {x: "B", y: 2}]
    expected = {values: values}
    assert_equal expected, Vega.lite.data(values).spec[:data]
    assert_equal expected, Vega.lite.data(values: values).spec[:data]
  end

  def test_data_url
    url = "http://www.example.org"
    expected = {url: url}
    assert_equal expected, Vega.lite.data(url).spec[:data]
    assert_equal expected, Vega.lite.data(url: url).spec[:data]
  end

  def test_transform
    expected = [{x: 1}, {y: 2}]
    assert_equal expected, Vega.lite.transform(x: 1).transform(y: 2).spec[:transform]
  end

  def test_transform_immutable
    expected_a = [{x: 1}]
    expected_b = [{x: 1}, {y: 2}]
    a = Vega.lite.transform(x: 1)
    b = a.transform(y: 2)
    assert_equal expected_a, a.spec[:transform]
    assert_equal expected_b, b.spec[:transform]
  end

  def test_transform_mutable
    expected = [{x: 1}, {y: 2}]
    a = Vega.lite.transform(x: 1)
    b = a.transform!(y: 2)
    assert_equal expected, a.spec[:transform]
    assert_equal expected, b.spec[:transform]
  end

  def test_encoding
    expected = {x: 1, y: 2}
    assert_equal expected, Vega.lite.encoding(x: 1).encoding(y: 2).spec[:encoding]
  end

  def test_encoding_immutable
    expected_a = {x: 1}
    expected_b = {x: 1, y: 2}
    a = Vega.lite.encoding(x: 1)
    b = a.encoding(y: 2)
    assert_equal expected_a, a.spec[:encoding]
    assert_equal expected_b, b.spec[:encoding]
  end

  def test_encoding_mutable
    expected = {x: 1, y: 2}
    a = Vega.lite.encoding(x: 1)
    b = a.encoding!(y: 2)
    assert_equal expected, a.spec[:encoding]
    assert_equal expected, b.spec[:encoding]
  end

  def test_spec
    expected = {x: 1}
    assert_equal expected, Vega.lite.spec(x: 1).spec[:spec]
  end

  def test_start
    values = [{x: "A", y: 1}, {x: "B", y: 2}]
    expected = [{values: values}]
    assert_equal expected, Vega.start.data(values).spec[:data]
    assert_equal expected, Vega.start.data(values: values).spec[:data]
  end

  def test_to_iruby
    result = Vega.lite.to_iruby
    assert_equal "text/html", result[0]
    assert_match "require(['vega', 'vega-lite', 'vega-embed']", result[1]
  end
end
