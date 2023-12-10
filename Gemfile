source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.4", ">= 7.0.4.3"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"
gem "hotwire-rails"
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Use Tailwind CSS [https://github.com/rails/tailwindcss-rails]
gem "tailwindcss-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
gem "redis", "~> 4.0"
gem 'redis-namespace'
gem 'redis-rails'
gem 'redis-rack-cache'
# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Sass to process CSS
# gem "sassc-rails"
gem "administrate"
gem "clearance"
# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"
gem 'httparty'
gem 'dotenv-rails'
gem 'pagy', '~> 6.0'
gem "chartkick"
gem "view_component"

group :development, :test do
	# See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
	gem "debug", platforms: %i[ mri mingw x64_mingw ]
	gem 'database_cleaner-active_record'
end

group :development do
	# Use console on exceptions pages [https://github.com/rails/web-console]
	gem "web-console"
	gem 'pry', '~> 0.14.2'
	gem 'pry-remote'
	gem 'pry-nav'
	gem 'annotate'
	# Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
	gem "rack-mini-profiler"
	gem 'bullet'
	gem 'stackprof'
	gem 'benchmark'
	# Speed up commands on slow machines / big apps [https://github.com/rails/spring]
	# gem "spring"
end

group :test do
	# Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
	gem "capybara"
	gem "selenium-webdriver"
	gem "webdrivers"
end

gem "dockerfile-rails", ">= 1.5", :group => :development

gem "sentry-ruby", "~> 5.10"

gem "sentry-rails", "~> 5.10"
