require 'test_helper'

describe Frappuccino::Stream do
  describe "#count" do
    it "returns a Stepper that's value is the current length of the Stream" do
      button = Button.new
      stream = Frappuccino::Stream.new(button)
      count = stream.count

      assert_equal 0, count.now

      button.push
      assert_equal 1, count.now
    end

    it "it only counts matching items if an argument is passed" do
      button = Button.new
      stream = Frappuccino::Stream.new(button)
      count = stream.count(1)

      assert_equal 0, count.now

      button.emit(0)
      assert_equal 0, count.now

      button.emit(1)
      assert_equal 1, count.now
    end

    it "it only counts the matching item if a block is given" do
      button = Button.new
      stream = Frappuccino::Stream.new(button)
      count = stream.count { |i| i > 1 }

      assert_equal 0, count.now

      button.emit(1)
      assert_equal 0, count.now

      button.emit(5)
      assert_equal 1, count.now
    end
  end
end
