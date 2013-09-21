require 'test_helper'

describe "lift" do
  it "returns a Property of the value" do
    prop = Frappuccino.lift("Property")
    assert_equal("Property", prop.now)
  end
end
