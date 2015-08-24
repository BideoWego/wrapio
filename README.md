# WrapIO

Allows the faking of input to STDIN and capturing of output from STDOUT with semantic method names. Great for testing!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'wrapio'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install wrapio

## Usage

### WrapIO
#### Captures output from STDOUT

```ruby
# wrapio_test.rb

output = WrapIO.of('input') do
	gets
	puts 'output'
end

puts output
```

```
$ ruby wrapio_test.rb

"Hello World!"
```

#### Enable debug to see the faked STDIN

```ruby
# wrapio_test.rb

WrapIO.debug = true
output = WrapIO.of('input') do
	gets
	puts 'output'
end

puts output
```

```
$ ruby wrapio_test.rb

-- WrapIO Capture#output  --
-- WrapIO Fake#gets 1 --
input
________________________
output

____________________________
```

### Or use the internal module classes separately

#### WrapIO::Fake

```ruby
# fake_test.rb

WrapIO::Fake.input('Hello!') do
	input = $stdin.gets
end
puts input
```

```
$ ruby fake_test.rb

"Hello!"
```

#### WrapIO::Capture

```ruby
# capture_test.rb

output = WrapIO::Capture.output do
	print "Hi!"
end
puts output
```

```
$ ruby capture_test.rb

"Hi!"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/wrapio. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

