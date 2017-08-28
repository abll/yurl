# The API Class for Yurl
# This will be the middle layer that the front end (CLI) calls in order to interact
# with the engine and aka.
# Options will be passed in order followed by parameters
require 'yurl'
require_relative 'engine'
require_relative 'aka'

module Yurl
  class API
    def self.dump(path, aka, pp, yaml)
      pp ||= false
      unless path.nil?
        yurl_object = Yurl::Engine.load_file(path)
        return yurl_object unless (yurl_object.respond_to?(:has_key?))
        return Yurl::Engine.pretty_print_yaml(yurl_object) if pp
        return Yurl::Engine.dump_yaml(yurl_object)
      end
      return 'AKA Not Implemented Yet' unless aka.nil?
      unless yaml.nil?
        return Yurl::Engine.pretty_print_yaml(yaml) if pp
        return Yurl::Engine.dump_yaml(yaml)
      end
      'No YAML found for yurl to process'
    end

    def self.get(path, aka, pp, yaml_url)
      pp ||= false
      unless path.nil?
        haystack = Yurl::Engine.load_file(path)
        return haystack unless (haystack.respond_to?(:has_key?))
        temp = Yurl::Engine.find(yaml_url, haystack)
        return Yurl::Engine.pretty_print_yaml(temp) if pp
        return Yurl::Engine.dump_yaml(temp)
      end
      return 'AKA Not Implemented Yet' unless aka.nil?
      "No Values found at specified location - #{yaml_url}"
    end

    def self.list
      Yurl::AKA.print_list(Yurl::AKA_PATH)
    end

    def self.add(aka, path)
      Yurl::AKA.add(Yurl::AKA_PATH, aka, path)
    end

    def self.remove(aka)
      Yurl::AKA.remove(Yurl::AKA_PATH, aka)
    end
  end
end
