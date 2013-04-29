require 'test_helper'

describe "map" do
  it "can take callbacks" do
    button = Button.new

    stream = Frappuccino::Stream.new(button)

    filtered_stream = stream
                        .map{|event| 1 }

    count = 0

    filtered_stream.on_value do |event|
      count += event
    end

    button.push
    button.push
    button.push

    assert_equal 3, count
  end

  it "maps events to values" do
    plus_button = PlusOneButton.new
    minus_button = MinusOneButton.new

    stream_one = Frappuccino::Stream.new(plus_button)
    stream_two = Frappuccino::Stream.new(minus_button)

    merged_stream = Frappuccino::Stream.merge(stream_one, stream_two)
    counter = merged_stream
              .map(:+ => 1, :- => -1, :default => 0)
              .inject(0) {|sum, n| sum + n }

    assert_equal 0, counter.to_i

    plus_button.push
    assert_equal 1, counter.to_i
  end

  it "respects the default value of the hash" do
    plus_button = PlusOneButton.new
    minus_button = MinusOneButton.new

    stream_one = Frappuccino::Stream.new(plus_button)
    stream_two = Frappuccino::Stream.new(minus_button)

    merged_stream = Frappuccino::Stream.merge(stream_one, stream_two)
    counter = merged_stream
              .map(:default => 1)
              .inject(0) {|sum, n| sum + n }

    assert_equal 0, counter.to_i

    plus_button.push
    minus_button.push
    assert_equal 2, counter.to_i
  end
end

describe "collect" do
  it "is a synonym for #map" do
    stream = Frappuccino::Stream.new(nil)

    map = stream.collect{|event| 1 }

    assert_kind_of Frappuccino::Map, map
  end
end

describe "#map_stream" do
  it "is a synonym for #map" do
    stream = Frappuccino::Stream.new(nil)

    map = stream.map_stream(:default => 1)

    assert_kind_of Frappuccino::Map, map
  end
end
