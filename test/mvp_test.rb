require 'test_helper'

require 'frappuccino'

describe "MVP interaction" do
  it "can subscribe to an event stream" do
    button = Button.new
    stream = Frappuccino::Stream.new(button)

    counter = stream
              .map {|event| event == :pushed ? 1 : 0 }
              .inject(0) {|sum, n| sum + n }

    assert_equal 0, counter.now

    3.times { button.push }
    assert_equal 3, counter.now

    button.push
    assert_equal 4, counter.now
  end
end
