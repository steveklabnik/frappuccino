require 'test_helper'

describe "merging steams" do
  it "produces one stream with both sets of events" do
    button_one = Button.new
    button_two = Button.new

    stream_one = Frappuccino::Stream.new(button_one)
    stream_two = Frappuccino::Stream.new(button_two)
    merged_stream = to_array(stream_one.merge(stream_two))

    button_one.push
    button_two.push

    assert_equal 2, merged_stream.length
  end

  it "+1/-1" do
    plus_button = PlusOneButton.new
    minus_button = MinusOneButton.new

    stream_one = Frappuccino::Stream.new(plus_button)
    stream_two = Frappuccino::Stream.new(minus_button)
    merged_stream = stream_one.merge(stream_two)
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
  
  it "works if the callee has a different constructor from Stream" do
    button_one = Button.new
    button_two = Button.new

    stream_one = Frappuccino::Stream.new(button_one).map { 0 }
    stream_two = Frappuccino::Stream.new(button_two)
    
    # This would explode if the merge was calling
    # self.class.new rather than Stream.new
    stream_one.merge(stream_two)
  end
end


describe "merging stream with Frappuccino::Stream#merge" do
  it "produces one stream with both sets of events" do
    button_one = Button.new
    button_two = Button.new

    stream_one = Frappuccino::Stream.new(button_one)
    stream_two = Frappuccino::Stream.new(button_two)
    merged_stream = to_array(Frappuccino::Stream.merge(stream_one, stream_two))

    button_one.push
    button_two.push

    assert_equal 2, merged_stream.length
  end
end