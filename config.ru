# encoding: utf-8

require 'rack/contrib/static_cache'
require 'rack/contrib/try_static'

root_path = File.expand_path('../build', __FILE__)

# XXX
use Rack::StaticCache,
  root: root_path,
  urls: %w(banner badge).map {|path| "/2013/images/#{path}" },
  duration: 1.0 / 365 / 24 / 2, # 30 min
  versioning: false

use Rack::StaticCache,
  root: root_path,
  urls: %w(javascripts stylesheets images).map {|path| "/2013/#{path}" },
  versioning: false

use Rack::TryStatic,
  root: root_path,
  urls: ['/'],
  try:  ['.html', 'index.html', '/index.html']

run lambda {|env| [404, {'Content-Type' => 'text/plain'}, ['Not found!']] }
