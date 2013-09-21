require "frappuccino/version"
require "frappuccino/stream"
require "frappuccino/property"

module Frappuccino
  def self.lift(value)
    Property.new(value)
  end
end
