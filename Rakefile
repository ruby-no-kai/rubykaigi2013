# coding: utf-8

require 'bundler'
Bundler.require

require 'yaml'
require 'active_attr'

class Speaker
  class << self
    attr_accessor :yaml_file

    def load
      read_yaml.each.with_object([]) {|(type, speakers), memo|
        speakers.each do |speaker|
          memo << new(speaker).tap {|s| s.type = type }
        end
      }
    end

    def dump(speakers)
      all_speakers = speakers.group_by(&:type).each.with_object({}) {|(type, speakers), memo|
        memo[type] = speakers.map {|speaker|
          speaker.attributes.except('type')
        }
      }

      write_yaml all_speakers
    end

    private

    def read_yaml
      YAML.load_file(yaml_file)
    end

    def write_yaml(data)
      File.write yaml_file, YAML.dump(data)
    end
  end

  include ActiveAttr::Model

  attribute :name
  attribute :type
  attribute :links
  attribute :gravatar

  def has_keynote?
    type == 'keynote_speakers'
  end

  def committer?
    type == 'committers'
  end
end

namespace :speakers do
  desc 'Update speakers.yml based on talks/*.yml'
  task :update do
    excepts = %w(S62.yml S56.yml S53.yml)

    talks_dir         = File.join(__dir__, 'data/talks')
    Speaker.yaml_file = File.join(__dir__, 'data/speakers.yml')

    source_speakers = Dir.glob("#{talks_dir}/S*.yml").each.with_object([]) {|path, memo|
      next if excepts.include?(File.basename(path))

      talk = YAML.load_file(path)

      talk['speakers'].each do |speaker|
        name, gravatar = speaker.values_at('name', 'gravatar')
        links          = speaker['links'] || {'github' => nil, 'twitter' => nil}
        type =
          if talk['keynote']
            'keynote_speakers'
          elsif speaker['committer']
            'committers'
          else
            'speakers'
          end

        memo << Speaker.new(name: name, gravatar: gravatar, links: links, type: type)
      end
    }

    speakers = Speaker.load
    source_speakers.each do |src|
      if speaker = speakers.find {|s| (src.gravatar.present? && s.gravatar == src.gravatar) || s.name == src.name }
        speaker.attributes = src.attributes
      else
        speakers << src
      end
    end

    Speaker.dump speakers
  end
end

namespace :assets do
  task :precompile => :build
end

desc "Build"
task :build do
  sh "middleman build --clean"
end
