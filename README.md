# WatirAngular

This gem will automatically wait for Angular events after each action that is 
likely to change the DOM. (Using `Watir::AfterHook` class)

This gem adds direct locator support for all `ng-` specific tags, like:

```ruby
browser.div(ng_model: 'foo')
browser.div(ng_class_even: 'bar')
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'watir_angular'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install watir_angular

## Usage

To have access to all `ng-*` locators and methods, simply require the gem 
```ruby
require "watir_angular"
```

To explicitly specify a wait for angular executions to complete
```ruby
browser = Watir::Browser.new
WatirAngular.wait_for_angular(browser)
```

To automatically wait for angular executions to complete after each method
```ruby
browser = Watir::Browser.new
WatirAngular.inject_angular_wait(browser)
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/titusfortner/watir_angular.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
