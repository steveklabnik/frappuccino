require 'test_helper'

describe "toggle" do
  it "toggles between two Properties on stream occurrences" do
    switch_button = Button.new
    plus_button = PlusOneButton.new
    minus_button = MinusOneButton.new

    switch = Frappuccino::Stream.new(switch_button)
    plus = to_prop(:+, Frappuccino::Stream.new(plus_button))
    minus = to_prop(:-, Frappuccino::Stream.new(minus_button))

    prop = plus.toggle(switch, minus)
    assert_equal(:+, prop.now)

    switch_button.push
    assert_equal(:-, prop.now)

    switch_button.push
    assert_equal(:+, prop.now)
  end
end
