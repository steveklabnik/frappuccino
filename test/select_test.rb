require 'test_helper'

describe "#select" do
  it "properly filters events from the stream" do
    points = Points.new
    button = Button.new

    stream = Frappuccino::Stream.new(points, button)

    filtered_stream = stream
                        .select{|event| event == :POINTS! }
                        .inject(0) {|sum, event| sum += 1 }

    total = 0

    filtered_stream.on_value do |event|
      total = event
    end

    points.POINTS!
    points.POINTS!
    points.POINTS!
    points.POINTS!
    points.POINTS!
    points.POINTS!
    points.POINTS!
    points.POINTS!
    points.POINTS!

    button.push
    button.push
    button.push
    button.push
    button.push
    button.push
    button.push

    assert_equal 9, total
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
