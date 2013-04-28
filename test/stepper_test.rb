require 'test_helper'

describe "Stepper" do
  describe "#now" do
    it "returns the current 'last' value of the Stream" do
      button = Button.new
      stream = Frappuccino::Stream.new(button)
      stepper = Frappuccino::Stepper.new(:not_pushed, button)

      button.push
      assert_equal :pushed, stepper.now
    end

    describe "when the input Stream is empty" do
      it "returns the zero value" do
        stream = Frappuccino::Stream.new(Object.new)
        stepper = Frappuccino::Stepper.new("zero", stream)
        assert_equal "zero", stepper.now
      end
    end
  end
end
