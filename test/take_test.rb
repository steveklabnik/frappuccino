require 'test_helper'

describe "take" do
  it "returns a Stream that only contains n elements" do
    button = CounterButton.new
    stream = Frappuccino::Stream.new(button)
    taken_stream = to_array(stream.take(2))

    3.times { button.push }
    assert_equal 2, taken_stream.length
    assert_equal [0, 1], taken_stream
  end
end
