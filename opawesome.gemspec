$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "opawesome/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "opawesome"
  s.version     = Opawesome::VERSION
  s.authors     = ["Alex Rehberg"]
  s.email       = ["hi@alexrehberg.com"]
  s.homepage    = "https://github.com/arehberg/opawesome"
  s.summary     = "Website optimization for Rails apps"
  s.description = "Website optimization for Rails apps"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.13"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'shoulda-matchers'

  s.test_files = Dir["spec/**/*"]
end
