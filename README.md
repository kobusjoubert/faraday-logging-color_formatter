# Faraday::Logging::ColorFormatter

Add some color to your Faraday logging output.

Before...

![before](https://user-images.githubusercontent.com/3071529/212807973-e87213da-d687-4db2-af70-5bb67eb81e0a.png)

After...

![after](https://user-images.githubusercontent.com/3071529/212807978-609ee381-f445-4d98-9994-31f7a4e5caa5.png)

## Installation

TODO: Replace `UPDATE_WITH_YOUR_GEM_NAME_PRIOR_TO_RELEASE_TO_RUBYGEMS_ORG` with your gem name right after releasing it to RubyGems.org. Please do not do it earlier due to security reasons. Alternatively, replace this section with instructions to install your gem from git if you don't plan to release to RubyGems.org.

Install the gem and add to the application's Gemfile by executing:

    $ bundle add UPDATE_WITH_YOUR_GEM_NAME_PRIOR_TO_RELEASE_TO_RUBYGEMS_ORG

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install UPDATE_WITH_YOUR_GEM_NAME_PRIOR_TO_RELEASE_TO_RUBYGEMS_ORG

## Usage

Add the following to your ruby program.

    require 'faraday/logging/color_formatter'

And then add the `Faraday::Logging::ColorFormatter` formatter to your logger middleware config.

    connection = Faraday.new(url: 'http://httpbingo.org') do |conn|
      conn.response :logger, ActiveSupport::Logger.new($stdout), formatter: Faraday::Logging::ColorFormatter
    end

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests and `rake rubocop` to run the linters. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kobusjoubert/faraday-logging-color_formatter.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
