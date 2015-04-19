source 'https://rubygems.org'

ruby '2.2.0'
#ruby-gemset=rails_in_action
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
#gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
 gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
 gem 'unicorn'


 gem 'sqlite3'
# Use Capistrano for deployment
  gem 'capistrano-rails', group: :development
  #gem 'capistrano-passenger',  group: :development
  #gem 'rvm1-capistrano3', require: false, group: :development
  gem 'capistrano-rvm',  group: :development
  gem 'capistrano-bundler',  group: :development
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  gem 'rspec-rails'

  gem 'guard-rspec'

  gem 'spring-commands-rspec'

  gem 'gmail'

  gem 'nokogiri'
 
end

group :test do

  gem 'capybara'

  gem 'factory_girl_rails'

  gem 'selenium-webdriver'
  
  gem 'database_cleaner', '1.0.1'

  gem 'email_spec'

  gem 'rack-test'

end

gem "cancan"

gem "carrierwave"

gem "searcher", git: "git://github.com/radar/searcher"

gem 'rails-observers'

gem 'responders'

group :production do
  gem 'pg'
end

gem "omniauth"
gem 'omniauth-facebook'
gem 'omniauth-github'

gem "kaminari"

gem 'actionpack-page_caching'
gem 'actionpack-action_caching'
