activate :directory_indexes

set :css_dir,    '2013/stylesheets'
set :js_dir,     '2013/javascripts'
set :images_dir, '2013/images'

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash, ignore: [%r{^2013/images/(?:banner|badge)}]
end
