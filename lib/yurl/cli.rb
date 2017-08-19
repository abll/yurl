require 'thor'
require 'pp'
require_relative 'yurl_reader'

module Yurl
    class CLI < Thor
        desc "hello", "Writes Hello World At Command Line"
        def hello 
            puts "Hello World!!"
        end
        
        desc "dump YAML", "Dumps Yaml Passed To Method"
        option :path
        option :nickname
        option :pp, :type => :boolean
        def dump(yml)
            if options[:pp]
                pp Yurl::YurlReader.pretty_print_yaml(yml)
            else 
                puts Yurl::YurlReader.dump_yaml(yml)
            end
        end

        desc "searches YAML @ Path/NickName for NEEDLE", "Searches Yaml For a Parameter"
        option :path
        option :nickname
        def get(needle)
            unless options[:path].nil?
                haystack = Yurl::YurlReader.load_file(options[:path])
                pp Yurl::YurlReader.find(needle, haystack)
            end
        end

        desc "inserts YAML to File", "Inserts Yaml "
        option :path
        option :nickname
        def post(yaml_url, value)
            puts "Need To Implement!!!"
        end        
    end
end