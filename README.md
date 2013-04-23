# Frappuccino

Functional Reactive Programming for Ruby.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'frappuccino', github: "steveklabnik/frappuccino"
```

(I'm hoping that @yoka will give me the gem name, until then, you
must install from GitHub.)

And then execute:

    $ bundle

Or install it yourself as:

    $ git clone https://github.com/steveklabnik/frappuccino
    $ cd frappuccino
    $ bundle
    $ rake install

## Usage

Basically, this:

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

You can also map via a hash, if you prefer:

```ruby
.map_stream(:pushed => 1, :default => 0)
```

Rather than convert via `#to_i`, which is pretty much a hack, you can register
a callback to occur when a value hits the stream:

```ruby
stream.on_value do |event|
  puts "I got a #{event}!"
end
```

You can combine two streams together:

```ruby
merged_stream = Frappuccino::Stream.merge(stream_one, stream_two)

# or

merged_stream = Frappuccino::Stream.new(button_one, button_two)
```

You can select events from a stream, too:

```ruby
stream = Frappuccino::Stream.new(button, something_else)
filtered_stream = stream.select{|event| event == :pushed }

filtered_stream.on_value do |event|
  # event will only ever be :pushed
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
