source 'https://rubygems.org'

ruby '2.1.0'

gem 'middleman', '~> 3.1.0'

gem 'rake'
gem 'active_attr'

group :development do
  gem 'rb-inotify'
  gem 'rb-fsevent', '~> 0.9'
end

group :production do
  gem 'rack-contrib', github: 'rack/rack-contrib'
  gem 'thin'
end
