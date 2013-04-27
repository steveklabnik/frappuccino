require 'test_helper'

describe Frappuccino::Stream do
  describe "#count" do
    it "gives the number of events that went through the stream" do
      button = Button.new

      stream = Frappuccino::Stream.new(button)

      button.push

      assert_equal 1, stream.count
    end

    it "cannot handle the block form" do
      stream = Frappuccino::Stream.new(nil)

      assert_raises(NotImplementedError) do
        stream.count do |x|
          x == 1
        end
      end
    end

    it "cannot handle the one-argument form" do
      stream = Frappuccino::Stream.new(nil)

      assert_raises(NotImplementedError) do
        stream.count(1)
      end
    end
  end
end
