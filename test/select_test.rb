require 'test_helper'

describe "#select" do
  it "properly filters events from the stream" do
    points = Points.new
    button = Button.new

    stream = Frappuccino::Stream.new(points, button)

    filtered_stream = to_array(stream.select{|event| event == :POINTS! })

    9.times { points.POINTS! }
    9.times { button.push }

    assert_equal 9, filtered_stream.length
    assert_equal true, filtered_stream.all? { |event| event == :POINTS! }
  end

  it "has #on_value" do
    points = Points.new
    button = Button.new

    stream = Frappuccino::Stream.new(points, button)

    filtered_stream = stream
                        .select{|event| event == :POINTS! }

    count = 0

    filtered_stream.on_value do |event|
      count += 1
    end

    points.POINTS!
    points.POINTS!
    button.push

    assert_equal 2, count
  end
end
