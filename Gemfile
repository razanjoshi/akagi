# if ENV["dev"]
#   # source 'http://ruby.taobao.org'
#   source 'https://ruby.taobao.org/'
# else
#   source 'https://rubygems.org'
# end
source 'https://gems.ruby-china.org'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails',  ' 5.0.0.1'
ruby '2.3.0'
# Use Puma as the app server
gem 'puma', '3.4.0'
# Use SCSS for stylesheets
gem 'bootstrap-sass', '3.3.6'
gem 'sass-rails', '5.0.6'
gem 'faker', '1.6.3'
gem 'will_paginate', '3.1.0'
gem 'bootstrap-will_paginate', '0.0.10'
gem 'carrierwave', '0.11.2'
gem 'mini_magick', '4.5.1'
gem 'fog', '1.38.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '3.0.0'
gem 'bcrypt', '3.1.11'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '4.2.1'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem 'commonmarker'
gem 'html-pipeline'
gem 'unicorn'
gem "font-awesome-rails"
gem 'momentjs-rails', '>= 2.9.0'
gem 'bootstrap3-datetimepicker-rails', '~> 4.7.14'
#gem 'breakpoint'
#gem 'compass'
# Use jquery as the JavaScript library
gem 'jquery-rails','4.1.1'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '5.0.1'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '2.4.1'
# Use Redis adapter to run Action Cable in production

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem "rinku",              "~> 1.7",   :require => false
gem "gemoji",             "~> 2.0",   :require => false
gem "RedCloth",           "~> 4.2.9", :require => false
gem "github-markdown",    "~> 0.5"
gem "email_reply_parser", "~> 0.5",   :require => false
gem "sanitize",           "~> 2.0",   :require => false
#gem 'rumoji'
gem 'weui-rails'
gem 'qiniu'

gem 'multipart-post'
gem 'pg'

gem 'redis', '~> 3.0'
gem 'redis-namespace'
gem 'weixin_authorize', git: 'https://github.com/wikimo/weixin_authorize.git'
gem 'weixin_rails_middleware'
gem 'settingslogic'




group :development, :test do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3', '1.3.11'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
      gem 'byebug', '9.0.0', platform: :mri


    if RUBY_VERSION < "2.1.0"
      gem "escape_utils",     "~> 0.3",   :require => false
      gem "github-linguist",  "~> 2.6.2", :require => false
    else
      gem "escape_utils",     "~> 1.0",   :require => false
      gem "github-linguist",  "~> 2.10",  :require => false
    end

    if RUBY_VERSION < "1.9.3"
      gem "activesupport", ">= 2", "< 4"
    end
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '3.1.1'
  gem 'listen', '3.0.8'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '1.7.2'
  gem 'spring-watcher-listen','2.0.0'
end

group :test do
 gem 'rails-controller-testing', '0.1.1'
 gem 'minitest-reporters', '1.1.9'
 gem 'guard', '2.13.0'
 gem 'guard-minitest', '2.4.4'
end

group :production do
  gem 'mysql2'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
