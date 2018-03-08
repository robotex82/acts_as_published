$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "acts_as_published/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "acts_as_published"
  s.version     = ActsAsPublished::VERSION
  s.authors     = ["Roberto Vasquez Angel"]
  s.email       = ["roberto@vasquez-angel.de"]
  s.homepage    = "https://github.com/robotex82/acts_as_published"
  s.summary     = "Acts as published beahviour for active record models."
  s.description = "Acts as published beahviour for active record models."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", ">= 3.2.0"

  # Module dependencies

  # Development Database
  s.add_development_dependency "sqlite3"

  # Development Server
  s.add_development_dependency 'rails-dummy'
  s.add_development_dependency "thin"

  # Documentation
  s.add_development_dependency "yard"

  # Active admin
  s.add_development_dependency 'activeadmin'
  s.add_development_dependency 'sass-rails'
  s.add_development_dependency "coffee-rails"

  # Tests
  s.add_development_dependency "pry-rails"
  s.add_development_dependency "capybara"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "test-unit"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency 'guard-rails'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'guard-bundler'
  s.add_development_dependency "shoulda-matchers"
end
