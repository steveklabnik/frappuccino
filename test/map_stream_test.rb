require 'test_helper'

require 'frappuccino/stream'

describe "#map_stream" do
  it "maps events to values" do
    plus_button = PlusOneButton.new
    minus_button = MinusOneButton.new

    stream_one = Frappuccino::Stream.new(plus_button)
    stream_two = Frappuccino::Stream.new(minus_button)

    merged_stream = Frappuccino::Stream.merge(stream_one, stream_two)
    counter = merged_stream
              .map_stream(:+ => 1, :- => -1, :default => 0)
              .inject(0) {|sum, n| sum + n }

    assert_equal 0, counter.to_i

    plus_button.push
    assert_equal 1, counter.to_i
  end
end
