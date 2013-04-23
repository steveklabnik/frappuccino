require 'test_helper'

describe "#on_value" do
  it "calls the block on a value" do
    button = Button.new
    stream = Frappuccino::Stream.new(button)

    clicked = false

    stream.on_value do |value|
      clicked = true
    end

    button.push

    assert clicked, "#on_value did not call back."
  end
end
