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
        return yurl_object unless yurl_object.respond_to?(:has_key?)
        return Yurl::API.return_yurl(yurl_object, pp)
      end
      unless aka.nil?
        yurl_object = Yurl::Engine.load_file(
          Yurl::AKA.get_aka(Yurl::AKA_PATH, aka)
        )
        return Yurl::API.return_yurl(yurl_object, pp)
      end
      return Yurl::API.return_yurl(yaml, pp) unless yaml.nil?
      'No YAML found for yurl to process'
    end

    def self.get(path, aka, pp, yaml_url)
      pp ||= false
      unless path.nil?
        haystack = Yurl::Engine.load_file(path)
        return haystack unless haystack.respond_to?(:has_key?)
        temp = Yurl::Engine.find(yaml_url, haystack)
        return Yurl::API.return_yurl(temp, pp)
      end
      unless aka.nil?
        haystack = Yurl::Engine.load_file(
          Yurl::AKA.get_aka(Yurl::AKA_PATH, aka)
        )
        return haystack unless haystack.respond_to?(:has_key?)
        temp = Yurl::Engine.find(yaml_url, haystack)
        return Yurl::API.return_yurl(temp, pp)
      end
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

    def self.return_yurl(yurl_object, pp)
      return Yurl::Engine.pretty_print_yaml(yurl_object) if pp == true
      Yurl::Engine.dump_yaml(yurl_object)
    end
  end
end
