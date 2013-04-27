require 'test_helper'

describe "zip" do
  it "returns a stream where the events are tuples of corresponding events" do
    button1 = Button.new
    stream1 = Frappuccino::Stream.new(button1)
    button2 = Button.new
    stream2 = Frappuccino::Stream.new(button2)

    occurred = nil

    zipped_stream = stream1.zip(stream2)
    zipped_stream.on_value do |event|
      occurred = event
    end

    button1.push
    button2.push

    assert_equal [:pushed, :pushed], occurred, "zipped stream did not propagate events correctly"

    occurred = nil

    button2.push
    button1.push

    assert_equal [:pushed, :pushed], occurred, "zipped stream did not propagate events correctly"
  end

  it "returns a stream that buffers either input stream until the other occurs" do
    button1 = Button.new
    stream1 = Frappuccino::Stream.new(button1)
    button2 = Button.new
    stream2 = Frappuccino::Stream.new(button2)

    occurred = []

    zipped_stream = stream1.zip(stream2)
    zipped_stream.on_value do |event|
      occurred << event
    end

    2.times do |i|
      button1.push
      assert_equal [], occurred, "zipped stream occurred too early"
    end

    2.times do |i|
      button2.push
      assert_equal occurred.length, i + 1, "zipped stream did not occur"
      assert_equal [:pushed, :pushed], occurred.last, "zipped stream did not occur with correct value"
    end

    occurred = []

    2.times do |i|
      button2.push
      assert_equal [], occurred, "zipped stream occurred too early"
    end

    2.times do |i|
      button1.push
      assert_equal occurred.length, i + 1, "zipped stream did not occur"
      assert_equal [:pushed, :pushed], occurred.last, "zipped stream did not occur with correct value"
    end
  end
end
