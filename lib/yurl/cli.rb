require 'thor'
require 'pp'
require_relative 'api'

module Yurl
    class CLI < Thor
        desc "hello", "Writes Hello World At Command Line"
        def hello 
            puts "Hello World!!"
        end
        
        desc "dump YAML", "Dumps Yaml Passed To Method"
        option :path
        option :aka
        option :pp, :type => :boolean
        def dump(yaml=nil)
            puts Yurl::API.dump(options[:path], options[:aka], options[:pp], yaml)
        end

        desc "searches YAML @ Path/aka for NEEDLE", "Searches Yaml For a Parameter"
        option :path
        option :aka
        option :pp, :type => :boolean
        def get(needle)
            puts Yurl::API.get(options[:path], options[:aka], options[:pp],needle)
        end

        desc "inserts YAML to File", "Inserts Yaml "
        option :path
        option :aka
        def post(yaml_url, value)
            puts "Need To Implement!!!"
        end        
    end
end