require 'test_helper'

describe "Source" do
  describe "#emit" do
    it "notifies observers" do
      pushed = nil
      source = Object.new.extend(Frappuccino::Source)
      source.add_observer(Observer.new { |value| pushed = value })
      source.emit("EVENT!")

      assert_equal "EVENT!", pushed, "#emit did not notify observers"
    end
  end
end
