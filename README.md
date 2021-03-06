# Marathon

[![CircleCI](https://circleci.com/gh/juanmanuelramallo/marathon.svg?style=shield)](https://circleci.com/gh/juanmanuelramallo/marathon)
[![Maintainability](https://api.codeclimate.com/v1/badges/c987a96aa491aa1d85bd/maintainability)](https://codeclimate.com/github/juanmanuelramallo/marathon/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/c987a96aa491aa1d85bd/test_coverage)](https://codeclimate.com/github/juanmanuelramallo/marathon/test_coverage)

Marathon allows you to run several bash commands and configure them by steps, so if any previous step has failed the execution gets stoped after the current step ends.

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

```bash
$ marathon -c 'command A in first step','command B in first step' -c 'command C in second step','command D in second step' -c 'command E in third step','you get the idea'
```

Some real life examples would be:
- To set rspec to run after all linters and static analizers:
```bash
marathon -c 'yarn test','bundle exec rubocop','bundle exec brakeman','yarn run js-lint','yarn run css-lint' -c 'bundle exec rspec'
```

- To set rspec to run after rubocop and after frontend linters:
```bash
marathon -c 'yarn run js-lint','yarn run css-lint' -c 'bundle exec rubocop' -c 'bundle exec rspec'
```

Order matters!

### Options

- Commands: `-c` List of commands of one step. You should enclose your commands with a single apostrophe and separate them using commas. If you want to specify a different step just write this option again.
```bash
marathon -c 'a command in step 1','other command in step 1','you get the idea' -c 'a command in step 2'
```
- Processes: `-p` `--processes` Number of processes to use to run the commands in every step. Only one process (main) by default.
```bash
marathon -c 'sleep 1','sleep 1' -p 2
```
- Verbose: `-v` `--verbose` As you may already guess, it prints more information on execution. Prints a message after the command has ended. And no matter the if the command was successful or not, the output is always displayed on stdout.
```bash
marathon -c 'echo Hola' -v
```

![Failed example image](https://i.imgur.com/jL9oGih.png)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

[Read the docs](http://marathon-docs.s3-website-us-west-2.amazonaws.com/)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/juanmanuelramallo/marathon. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Marathon project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](CODE_OF_CONDUCT.md).
