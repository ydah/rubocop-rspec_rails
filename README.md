# RuboCop RSpec Rails

[![Join the chat at https://gitter.im/rubocop-rspec/Lobby](https://badges.gitter.im/rubocop-rspec/Lobby.svg)](https://gitter.im/rubocop-rspec/Lobby)
[![Gem Version](https://badge.fury.io/rb/rubocop-rspec-rails.svg)](https://rubygems.org/gems/rubocop-rspec-rails)
![CI](https://github.com/rubocop/rubocop-rspec-rails/workflows/CI/badge.svg)

[RSpec Rails](https://rspec.info/)-specific analysis for your projects, as an extension to
[RuboCop](https://github.com/rubocop/rubocop).

## Installation

Just install the `rubocop-rspec-rails` gem

```bash
gem install rubocop-rspec-rails
```

or if you use bundler put this in your `Gemfile`

```ruby
gem 'rubocop-rspec-rails', require: false
```

## Usage

You need to tell RuboCop to load the RSpec Rails extension. There are three
ways to do this:

### RuboCop configuration file

Put this into your `.rubocop.yml`.

```yaml
require: rubocop-rspec-rails
```

Alternatively, use the following array notation when specifying multiple extensions.

```yaml
require:
  - rubocop-rspec
  - rubocop-rspec-rails
```

Now you can run `rubocop` and it will automatically load the RuboCop RSpec Rails
cops together with the standard cops.

### Command line

```bash
rubocop --require rubocop-rspec-rails
```

### Rake task

```ruby
RuboCop::RakeTask.new do |task|
  task.requires << 'rubocop-rspec-rails'
end
```

## Documentation

You can read more about RuboCop RSpec in its [official manual](https://docs.rubocop.org/rubocop-rspec-rails).

## The Cops

All cops are located under
[`lib/rubocop/cop/rspec-rails`](lib/rubocop/cop/rspec-rails), and contain
examples/documentation.

In your `.rubocop.yml`, you may treat the RSpec cops just like any other
cop. For example:

```yaml
RSpec/Rails/AvoidSetupHook:
  Exclude:
    - spec/my_poorly_named_spec_file.rb
```

## Contributing

Checkout the [contribution guidelines](.github/CONTRIBUTING.md).

## License

`rubocop-rspec-rails` is MIT licensed. [See the accompanying file](MIT-LICENSE.md) for
the full text.
