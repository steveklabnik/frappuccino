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

  it "allows for multiple callbacks per Stream" do
    button = Button.new
    stream = Frappuccino::Stream.new(button)

    callback1 = false
    callback2 = false

    stream.on_value do |value|
      callback1 = value
    end

    stream.on_value do |value|
      callback2 = value
    end

    button.push

    assert_equal :pushed, callback1, "#on_value did not call first callback"
    assert_equal :pushed, callback2, "#on_value did not call second callback"
  end

  it "works with inject" do
    button = Button.new
    stream = Frappuccino::Stream.new(button)

    counter = stream.inject(0) {|sum, event| sum + 1 }

    sum1 = 0
    sum2 = 0

    counter.on_value do |value|
      sum1 = value
    end

    counter.on_value do |value|
      sum2 = value
    end

    button.push

    assert_equal 1, sum1, "#on_value did not call first callback"
    assert_equal 1, sum2, "#on_value did not call second callback"
  end
end
