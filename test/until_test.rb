require 'test_helper'

describe "until" do
  it "switches the Property on the Stream occurring" do
    switch_button = Button.new
    plus_button = PlusOneButton.new
    minus_button = MinusOneButton.new

    switch = Frappuccino::Stream.new(switch_button)
    plus = to_prop(:notplus, Frappuccino::Stream.new(plus_button))
    minus = to_prop(:notminus, Frappuccino::Stream.new(minus_button))

    prop = plus.until(switch, minus)
    assert_equal(:notplus, prop.now)

    plus_button.push
    assert_equal(:+, prop.now)

    minus_button.push
    switch_button.push
    assert_equal(:-, prop.now)
  end
end
