# frozen_string_literal: true

require_relative 'lib/faraday/logging/color_formatter/version'

Gem::Specification.new do |spec|
  spec.name = 'faraday-logging-color_formatter'
  spec.version = Faraday::Logging::ColorFormatter::VERSION
  spec.authors = ['Kobus Joubert']
  spec.email = ['kobus@translate3d.com']

  spec.summary = 'Faraday color logging formatter'
  spec.description = 'Add some color to your Faraday logging output.'
  spec.homepage = 'https://github.com/kobusjoubert/faraday-logging-color_formatter'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.6.0'
  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/kobusjoubert/faraday-logging-color_formatter'
  spec.metadata['changelog_uri'] = 'https://github.com/kobusjoubert/faraday-logging-color_formatter/CHANGELOG.md'
  spec.metadata['rubygems_mfa_required'] = 'true'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|circleci)|appveyor)})
    end
  end

  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'faraday', '~> 2.7'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
