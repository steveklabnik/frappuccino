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
end
