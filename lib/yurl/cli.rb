require 'thor'
require 'pp'
require_relative 'aka'
require_relative 'api'
require 'yurl'

module Yurl
  class CLI < Thor
    desc 'hello', 'Writes Hello World At Command Line'
    def hello
      puts 'Hello World!!'
    end

    ######################## Engine ############################

    desc 'dump YAML', 'Dumps Yaml Passed To Method'
    option :path
    option :aka
    option :pp, type: :boolean
    def dump(yaml = nil)
      puts Yurl::API.dump(options[:path], options[:aka], options[:pp], yaml)
    end

    desc 'searches YAML @ Path/aka for NEEDLE', 'Searches Yaml For a Parameter'
    option :path
    option :aka
    option :pp, type: :boolean
    def get(needle)
      puts Yurl::API.get(options[:path], options[:aka], options[:pp], needle)
    end

    ######################### AKA ############################

    desc 'List Everything in AKA', 'Dumps Aka'
    def list
      puts Yurl::API.list
    end

    desc 'Add AKA and paths', 'Inserts Elements To AKA'
    def add(aka, path)
      puts Yurl::API.add(aka, path)
    end

    desc 'Remove AKA', 'Removes AKA From AKA List'
    def remove(aka)
      puts Yurl::API.remove(aka)
    end

    desc 'List version of yurl gem', 'Lists version'
    def version
      puts Yurl::VERSION
    end
  end
end
