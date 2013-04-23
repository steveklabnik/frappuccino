require 'test_helper'

describe "#on_value" do
  it "calls the block on a value" do
    button = Button.new
    stream = Frappuccino::Stream.new(button)

    event = false

    stream.on_value do |value|
      event = value
    end

    button.push

    assert_equal :pushed, event, "#on_value did not call back."
  end
end
