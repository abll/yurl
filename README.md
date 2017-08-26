# Yurl

Welcome to yurl, a ruby gem inspired by a problem and a conversation. The problem - the abundance of YAML files in Rails, Cloud Foundry, Docker and whatever your favorite tool is. I wanted a way to easily access the information in these files, without having to have multiple tabs open in my text editor. After looking at vault.io (way too much overhead) and creating config servers in both Spring and Node-red (boo java && javascript), a conversation with an intern (Thanks Nick T) led me to a much simpler solution (KISS always works). Yurl (Yaml Url) is a command line tool that attempts to mirror the curl/REST interface to query information from YAML files.

Yurl is both my first ruby gem and open source project of any kind, it was and continues to be a great learning experience. I plan to refactor and implement new features so please excuse the bugs, weird commits and bad code(lol) and feel free to contribute. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'yurl'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install yurl

## Usage

Given a directory with yaml file named "info.yaml" with contents: 
Production:
    Database:
        Username: foo
        password : bar

Running yurl get --path=<path to directory>/info.yaml "Production/Database/Username" yields "foo"

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/yurl. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Yurl project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/yurl/blob/master/CODE_OF_CONDUCT.md).
