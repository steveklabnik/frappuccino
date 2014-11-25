require 'test_helper'

describe "reduce" do
  it "is a synonym for #inject" do
    button = Button.new
    stream = Frappuccino::Stream.new(button)

    counter = stream.map(:default => 1)
                  .reduce(0) { |sum, n| sum + n }

    assert_equal 0, counter.now

    3.times { button.push }
    assert_equal 3, counter.now

    button.push
    assert_equal 4, counter.now
  end
end
