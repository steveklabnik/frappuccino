require 'test_helper'

describe "drop" do
  it "ignores the first n events" do
    button = CounterButton.new
    stream = Frappuccino::Stream.new(button)
    dropped_stream = to_array(stream.drop(3))

    5.times { button.push }
    assert_equal 2, dropped_stream.length
    assert_equal [3, 4], dropped_stream
  end
end
