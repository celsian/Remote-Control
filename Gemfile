source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails'
gem 'thin'

gem "pg"

gem 'devise'

#For ruby gpio <--------------
gem 'pi_piper', '~> 1.3.2' #This older version works, newer version does not actuate my pins.

#For statistical analysis
gem "chartkick"
gem 'groupdate'

#Turbo links to stop the loading JS and CSS on every page load.
gem 'turbolinks'
gem 'jquery-turbolinks'

#Gem for workers:
gem 'sidekiq'
gem 'sinatra', '>= 1.3.0', :require => nil

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
gem 'bootstrap-sass', '~> 3.3.6'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :test, :development do
  gem 'capybara'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'guard-rspec'
  gem 'pry'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :production do

end