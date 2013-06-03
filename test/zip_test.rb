require 'test_helper'

describe "zip" do
  it "returns a stream where the events are tuples of corresponding events" do
    button1 = CounterButton.new(0)
    stream1 = Frppuccino::Stream.new(button1)
    button2 = CounterButton.new(10)
    stream2 = Frppuccino::Stream.new(button2)


    zipped_stream = to_array(stream1.zip(stream2))

    button1.push
    button2.push
    assert_equal [[0, 10]], zipped_stream, "zipped stream did not propagate events correctly"

    button2.push
    button1.push
    assert_equal [[0, 10], [1, 11]], zipped_stream, "zipped stream did not propagate events correctly"
  end

  it "returns a stream that buffers the left input stream" do
    button1 = CounterButton.new(0)
    stream1 = Frppuccino::Stream.new(button1)
    button2 = CounterButton.new(10)
    stream2 = Frppuccino::Stream.new(button2)

    zipped_stream = to_array(stream1.zip(stream2))

    2.times do |i|
      button1.push
      assert_equal [], zipped_stream, "zipped stream occurred too early"
    end

    2.times do |i|
      button2.push
      assert_equal zipped_stream.length, i + 1, "zipped stream did not occur"
      assert_equal [i, 10 + i], zipped_stream.last, "zipped stream did not occur with correct value"
    end

    zipped_stream.clear
  end

  it "returns a stream that buffers the right input stream" do
    button1 = CounterButton.new(0)
    stream1 = Frppuccino::Stream.new(button1)
    button2 = CounterButton.new(10)
    stream2 = Frppuccino::Stream.new(button2)

    zipped_stream = to_array(stream1.zip(stream2))

    2.times do |i|
      button2.push
      assert_equal [], zipped_stream, "zipped stream occurred too early"
    end

    2.times do |i|
      button1.push
      assert_equal zipped_stream.length, i + 1, "zipped stream did not occur"
      assert_equal [i, 10 + i], zipped_stream.last, "zipped stream did not occur with correct value"
    end

  end
end
