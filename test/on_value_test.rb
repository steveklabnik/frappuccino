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

  it "works with mapped Streams" do
    button = Button.new
    stream = Frappuccino::Stream.new(button)

    callback = false

    stream.map { |val| :true }.on_value do |val|
      callback = val
    end

    button.push

    assert_equal :true, callback, "#on_value did not call back."
  end

  it "works with filtered Streams" do
    button = Button.new
    stream = Frappuccino::Stream.new(button)

    callback = false
    should = true

    stream.select { |val| should }.on_value do |val|
      callback = val
    end

    button.push
    assert_equal :pushed, callback, "#on_value did not call back."

    should = false
    callback = :didnot
    button.push

    assert_equal :didnot, callback, "#on_value did call back."
  end
end
