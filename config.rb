activate :directory_indexes

set :css_dir,    '2013/stylesheets'
set :js_dir,     '2013/javascripts'
set :images_dir, '2013/images'

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash, ignore: [%r{^2013/images/(?:banner|badge|image)}]
end

data.talks.keys.each do |id|
  talk = data.talks[id]

  next if talk.start_with?('S')
  next if talk.title.blank?
  next if talk.description.blank?

  proxy "/2013/talk/#{id}.html", '/2013/talk.html', locals: {id: id}
end
ignore '/2013/talk.html'

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
    partial 'schedule_cell', locals: {id: id, talk: data.talks[id.to_s]}
  end

  def gravatar_tag(id, size, options = {})
    default_image = CGI.escape('http://rubykaigi.org/2013/commonNoImage.png')
    image_tag("http://www.gravatar.com/avatar/#{id}?s=#{size}&d=#{default_image}", options.merge(width: size, height: size))
  end

  def link_to_if(condition, text, href, options = {})
    if condition
      link_to text, href, options
    else
      text
    end
  end

  def appeal_sponsor(talk_id)
    data.sponsors.values.flatten.find {|sponsor| sponsor.appeal_talk_id == talk_id.to_s }
  end

  def normalize_spoken_language(talk)
    label = []
    label << '[EN]' if /English/.match(talk.spoken_language)
    label << '[JA]' if /Japanese/.match(talk.spoken_language)
    label.join
  end
end
