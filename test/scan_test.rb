require 'test_helper'

describe "scan" do
  it "returns a stream where every element is the result of the passed block applied to the last result and the current element" do
    button =  Button.new
    stream = Frppuccino::Stream.new(button)
    count_stream = to_array(stream.scan(0) { |last, current|
      last + 1
    })

    5.times { button.push }
    assert_equal [1,2,3,4,5], count_stream
  end
end
