source 'https://rubygems.org'

ruby '2.0.0'

gem 'middleman', '~> 3.1.0'

group :development do
  gem 'rake'
  gem 'active_attr'
  gem 'rb-inotify'
  gem 'rb-fsevent', '~> 0.9'
end

group :production do
  gem 'rack-contrib', github: 'rack/rack-contrib'
  gem 'thin'
end
