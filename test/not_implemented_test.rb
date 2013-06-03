require 'test_helper'

describe "not implemented methods" do
  [:all?,
   :any?,
   :chunk,
   :cycle,
   :find,
   :detect,
  ].each do |m|
    it "#{m} is not implemented because it's nonsensical" do
      assert_raises(NotImplementedError) do
        stream = Frppuccino::Stream.new(nil)
        stream.send(m)
      end
    end
  end
end
