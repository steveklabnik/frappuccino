require 'test_helper'

describe "Property" do
  describe "#now" do
    it "returns the current 'last' value of the Stream" do
      button = Button.new
      stream = Frppuccino::Stream.new(button)
      stepper = Frppuccino::Property.new(:not_pushed, stream)

      button.push
      assert_equal :pushed, stepper.now
    end

    describe "when the input Stream is empty" do
      it "returns the zero value" do
        stream = Frppuccino::Stream.new(Object.new)
        stepper = Frppuccino::Property.new("zero", stream)
        assert_equal "zero", stepper.now
      end
    end
  end
end
