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

Given a directory with YAML file named "info.yaml" with contents:

```yaml 
Production:
    Database:
        username: foo
        password : bar
        Parameter With Spaces:
            value: Some More Foo

```

### Dump

This command is used to dump the contents of a yaml file to STD:OUT

    $ yurl dump --path=info.yml
    #=> {"Production"=>{"Database"=>{"username"=>"foo", "password"=>"bar", "Parameter With Spaces"=>{"value"=>"Some More Foo"}}}}

To pretty print the contents of the YAML file

    $ yurl dump --pp --path=info.yml
    #=> {"Production"=>
            {"Database"=>
                {"username"=>"foo",
                "password"=>"bar",
                "Parameter With Spaces"=>{"value"=>"Some More Foo"}}}}
 
### Get

This command is used to access the data at a certain node in the YAML file. To access nested content use a '/' to descend the different nested levels. 

    $ yurl get --path=info.yml Production
    #=> "Database"=>{"username"=>"foo", "password"=>"bar", "Parameter With Spaces"=>{"value"=>"Some More Foo"}}}

    $ yurl get --path=info.yaml Production/Database/username
    #=> "foo"

If your YAML fields have spaces enclose them in "" i.e

    $ yurl get --path=info.yml "Production/Database/Parameter With Spaces"
    #=> {"value"=>"Some More Foo"}

### AKA 

Yurl also has the ability to store paths to yaml files as "also known as" (AKA). In order to shorten the length of commands to access YAML data. To add a element to the AKA List:

    $ yurl add info ./info.yaml
    #=> Added AKA - info with path ./info.yml

    $ yurl add "aka with spaces" info.yml
    #=> Added AKA - aka with spaces with path info.yml

To list the current AKA's

    $ yurl list
    #=> {"AKA List"=>"Add Some AKAs", "aka with spaces"=>"info.yml", "info"=>"info.yml"}

To remove an AKA

    $ yurl remove "AKA List"
    #=> Deleted AKA - AKA List

    $ yurl list
    #=> {"aka with spaces"=>"info.yml", "info"=>"info.yml"}

Then YAML information can be queried as such

    $ yurl get --aka=info "Production/Database/Username"
    #=> "foo"

    $ yurl get --aka="aka with spaces" "Production/Database/username"
    #=> "foo"

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/abll/yurl. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Yurl project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/yurl/blob/master/CODE_OF_CONDUCT.md).
