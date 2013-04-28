require 'test_helper'

describe "drop" do
  it "ignores the first n events" do
    button = Button.new

    stream = Frappuccino::Stream.new(button)
    dropped_stream = stream.drop(3)

    count = 0
    dropped_stream.on_value do |value|
      count += 1
    end

    5.times { button.push }

    assert_equal 2, count
  end
end
