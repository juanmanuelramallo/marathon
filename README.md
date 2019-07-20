# Marathon

Marathon allows you to run several bash commands and congiure them by run levels, so if any previous level has failed the execution gets stoped after the current level ends.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'marathon'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install marathon

## Usage

To set rspec to run after all linters and static analizers:
```bash
marathon -c 'bundle exec rspec;;2','yarn test','bundle exec rubocop','bundle exec brakeman','yarn run js-lint','yarn run css-lint'
```

To set rspec to run after rubocop and after frontend linters:
```bash
marathon -c 'yarn run js-lint','yarn run css-lint','bundle exec rubocop;;2','bundle exec rspec;;3'
```

![failed example image](https://i.imgur.com/zCIQCGI.png)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/juanmanuelramallo/marathon. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Marathon project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](CODE_OF_CONDUCT.md).
