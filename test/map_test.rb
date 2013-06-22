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

    merged_stream = stream_one.merge(stream_two)
    mapped_stream = to_array(merged_stream.map(:+ => 1, :- => -1, :default => 0))

    assert_equal [], mapped_stream

    plus_button.push
    assert_equal [1], mapped_stream

    minus_button.push
    assert_equal [1, -1], mapped_stream
  end

  it "respects the default value of the hash" do
    plus_button = PlusOneButton.new
    minus_button = MinusOneButton.new

    stream_one = Frappuccino::Stream.new(plus_button)
    stream_two = Frappuccino::Stream.new(minus_button)

    merged_stream = stream_one.merge(stream_two)
    mapped_stream = to_array(merged_stream.map(:default => 1))

    assert_equal [], mapped_stream

    plus_button.push
    minus_button.push
    assert_equal [1, 1], mapped_stream
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
