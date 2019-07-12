
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "marathon/version"

Gem::Specification.new do |spec|
  spec.name          = "marathon"
  spec.version       = Marathon::VERSION
  spec.authors       = ["Juan Manuel Ramallo"]
  spec.email         = ["ramallojuanm@gmail.com"]

  spec.summary       = %q{Tests runner}
  spec.description   = %q{Test runner that receives a list of commands and runs them concurrently and display a nice formatted view}
  spec.homepage      = "https://github.com/juanmanuelramallo"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://github.com/juanmanuelramallo/marathon"
    spec.metadata["changelog_uri"] = "https://github.com/juanmanuelramallo/marathon/master/tree/changelog.md"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = ["lib/marathon.rb", "lib/marathon/parser.rb", "lib/marathon/run.rb", "lib/marathon/version.rb"]
  spec.bindir        = "bin"
  spec.executables   = ["marathon"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0.2"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.8"
  spec.add_runtime_dependency('colorize')
end
