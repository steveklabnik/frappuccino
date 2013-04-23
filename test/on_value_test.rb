require 'test_helper'

describe "#on_value" do
  it "calls the block on a value" do
    button = Button.new
    stream = Frappuccino::Stream.new(button)

    event = false

    stream.on_value do |value|
      event = value
    end

    button.push

    assert_equal :pushed, event, "#on_value did not call back."
  end

  it "works with inject" do
    button = Button.new
    stream = Frappuccino::Stream.new(button)

    counter = stream.inject(0) {|sum, event| sum + 1 }

    sum = 0

    counter.on_value do |value|
      sum = value
    end

    button.push

    assert_equal 1, sum, "#on_value did not call back."
  end
end
