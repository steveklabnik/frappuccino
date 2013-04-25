require 'test_helper'

class Points
  def POINTS!
    emit(:POINTS!)
  end
end

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

    9.times { points.POINTS! }

    9.times { button.push }

    assert_equal 9, total
  end
end
