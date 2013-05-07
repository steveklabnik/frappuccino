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

    assert_equal 2, counter.now
  end

  it "+1/-1" do
    plus_button = PlusOneButton.new
    minus_button = MinusOneButton.new

    stream_one = Frappuccino::Stream.new(plus_button)
    stream_two = Frappuccino::Stream.new(minus_button)

    merged_stream = Frappuccino::Stream.merge(stream_one, stream_two)
    counter = merged_stream
              .map do |event|
                case event
                when :+
                  1
                when :-
                  -1
                else
                  0
                end
              end
              .inject(0) {|sum, n| sum + n }

    assert_equal 0, counter.now

    plus_button.push
    assert_equal 1, counter.now

    minus_button.push
    assert_equal 0, counter.now

    2.times { minus_button.push }
    assert_equal(-2, counter.now)

    4.times { plus_button.push }
    assert_equal 2, counter.now
  end
end
