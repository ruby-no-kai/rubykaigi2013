activate :directory_indexes

set :css_dir,    '2013/stylesheets'
set :js_dir,     '2013/javascripts'
set :images_dir, '2013/images'

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash, ignore: [%r{^2013/images/(?:banner|badge)}]
end

data.sessions.keys.each do |id|
  proxy "/2013/session/#{id}.html", '/2013/session.html', locals: {id: id}
end
ignore '/2013/session.html'

helpers do
  def sponsor_weight_to_size(weight)
    weight_to_size = {4 => '220', 3 => '180', 2 => '135', 1 => '90'}
    weight_to_size[weight]
  end

  def sponsor_logo_tag(sponsor)
    logo = "sponsors#{sponsor.id}.png"
    link_to image_tag(logo, alt: sponsor.name, width: sponsor_weight_to_size(sponsor.weight)), sponsor.link, target: '_blank'
  end

  def schedule_cell(id)
    partial 'schedule_cell', locals: {id: id, session: data.sessions[id.to_s]}
  end
end
