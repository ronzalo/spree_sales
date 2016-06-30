# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_sales'
  s.version     = '3.0.0'
  s.summary     = 'Add sales prices to products'
  s.description = 'Add sales prices to products'
  s.required_ruby_version = '>= 2.1.0'

  s.author    = 'Gonzalo Moreno'
  s.email     = 'gmoreno@acid.cl'
  s.homepage  = 'http://www.acid.cl'
  s.license   = 'MIT'

  #s.files       = `git ls-files`.split("\n")
  #s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '~> 3.1.0'
  s.add_dependency 'spree_frontend', '~> 3.1.0'
  s.add_dependency 'date_validator'


  s.add_development_dependency 'capybara', '~> 2.1'
  s.add_development_dependency 'coffee-rails'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_girl', '~> 4.4'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails',  '~> 3.5'
  s.add_development_dependency 'sass-rails', '~> 5.0.0.beta1'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'sqlite3'
end
