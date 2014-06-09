require "frappuccino/version"
require "frappuccino/stream"
require "frappuccino/property"

module Frappuccino
  def self.lift(value)
    Property.new(value)
  end
end

class Object
  def method_missing(method, *args, &block)
    if Frappuccino::Property.method_defined?(method)
      Frappuccino.lift(self).public_send(method, *args, &block)
    else
      super(method, *args, &block)
    end
  end
end
