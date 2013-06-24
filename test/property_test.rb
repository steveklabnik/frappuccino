require 'test_helper'

describe "Property" do
  describe "#now" do
    it "returns the current 'last' value of the Stream" do
      button = Button.new
      stream = Frappuccino::Stream.new(button)
      stepper = Frappuccino::Property.new(:not_pushed, stream)

      button.push
      assert_equal :pushed, stepper.now
    end

    describe "when the input Stream is empty" do
      it "returns the zero value" do
        stream = Frappuccino::Stream.new(Object.new)
        stepper = Frappuccino::Property.new("zero", stream)
        assert_equal "zero", stepper.now
      end
    end
  end

  describe "#sample" do
    before do
      @counter = CounterButton.new(1)
      stream = Frappuccino::Stream.new(@counter)
      prop = Frappuccino::Property.new(0, stream)

      @sampler = Button.new
      @samples = to_array(prop.sample(Frappuccino::Stream.new(@sampler)))
    end

    it "has no occurrences initally" do
      assert_equal @samples, []
    end

    it "samples the Property when the passed Stream occurs" do
      @sampler.push
      assert_equal @samples, [0]

      @counter.push
      @sampler.push
      assert_equal @samples, [0, 1]
    end
  end
end
