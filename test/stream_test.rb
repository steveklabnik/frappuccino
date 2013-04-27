require 'test_helper'

describe Frappuccino::Stream do
  describe "#count" do
    it "gives the number of events that went through the stream" do
      button = Button.new

      stream = Frappuccino::Stream.new(button)

      button.push

      assert_equal 1, stream.count
    end
  end
end
