# Frappuccino

Functional Reactive Programming for Ruby.

[![Build Status](https://travis-ci.org/steveklabnik/frappuccino.png?branch=master)](https://travis-ci.org/steveklabnik/frappuccino) [![Code Climate](https://codeclimate.com/github/steveklabnik/frappuccino.png)](https://codeclimate.com/github/steveklabnik/frappuccino) [![Coverage Status](https://coveralls.io/repos/steveklabnik/frappuccino/badge.png?branch=master)](https://coveralls.io/r/steveklabnik/frappuccino)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'frappuccino'
```

And then execute:

``` sh
$ bundle
```

Or install it yourself as:

``` sh
$ git clone https://github.com/steveklabnik/frappuccino
$ cd frappuccino
$ bundle
$ rake install
```

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

counter.now # => 0

button.push
button.push
button.push

counter.now # => 3

button.push

counter.now # => 4
```

You can also map via a hash, if you prefer:

```ruby
.map(:pushed => 1, :default => 0)
```

You can also register callbacks to a Stream. These will be executed for
each event that occurs in the Stream:

```ruby
stream.on_value do |event|
  puts "I got a #{event}!"
end
```

You can combine two streams together:

```ruby
merged_stream = stream_one.merge(stream_two)

# or

merged_stream = Frappuccino::Stream.merge(one_stream , other_stream)

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
