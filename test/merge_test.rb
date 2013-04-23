require 'test_helper'

describe "merging steams" do
  it "produces one stream with both sets of events" do
    button_one = Button.new
    button_two = Button.new

    stream_one = Frappuccino::Stream.new(button_one)
    stream_two = Frappuccino::Stream.new(button_two)

    merged_stream = Frappuccino::Stream.merge(stream_one, stream_two)
    counter = merged_stream
              .map {|event| event == :pushed ? 1 : 0 }
              .inject(0) {|sum, n| sum + n }

    button_one.push
    button_two.push

    assert_equal 2, counter.to_i
  end
end
