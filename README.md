# Frappuccino

Functional Reactive Programming for Ruby.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'frappuccino'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install frappuccino

## Usage

Right this moment, just the initial example works:

```ruby
require 'frappuccino'

class Button
  def push
    emit(:pushed) # emit sends a value into the stream
  end
end

button = Button.new
stream = Frappuccino::Stream.new(button)

counter = stream
            .map {|event| event == :pushed ? 1 : 0 } # convert events to ints
            .inject(0) {|sum, n| sum + n } # add them up

counter.to_i # => 0

button.push
button.push
button.push

counter.to_i # => 3

button.push

counter.to_i # => 4
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
