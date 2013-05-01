require 'test_helper'

describe "take" do
  it "returns a Stream that only contains n elements" do
    button = CounterButton.new
    stream = Frappuccino::Stream.new(button)
    taken_stream = stream.take(2)

    pushed = []
    taken_stream.on_value do |value|
      pushed << value
    end

    3.times { button.push }
    assert_equal 2, pushed.length
    assert_equal [0, 1], pushed
  end
end
