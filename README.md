# SexpInfo

This gem provides nice information about your program based on Ripper sexps. Given a ruby source file called foo.rb

```ruby
class Foo
  def bar(baz, quux = 123)
    "yikes"
  end
end
```

we can do the folliwng

```ruby
  rip = Ripper.sexp(File.read('foo.rb'))
  si = SexpInfo.new(rip)
  si.defined_methods # => ["bar"]
  si["bar"].arity # => 2
  si["bar"].args[1].optional? # => true
```

Please check the specs for more information


## Installation

Add this line to your application's Gemfile:

    gem 'sexp_info'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sexp_info


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
