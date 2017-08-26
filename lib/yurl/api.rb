# The API Class for Yurl
#This will be the middle layer that the front end (CLI) calls in order to interact 
# with the engine and aka.
# Options will be passed in order followed by parameters
require 'yurl'
require_relative "engine"
require_relative "aka"

module Yurl
    class API
        def self.dump(path, aka, pp, yaml)
            pp ||= false
            unless(path.nil?)
                begin
                    temp = Yurl::Engine.load_file(path)
                rescue ArgumentError => e
                    return e.message
                rescue Exception => e
                    return "Unhandled Exception #{e.class} Occurred"
                end
                return Yurl::Engine.pretty_print_yaml(temp) if pp
                return Yurl::Engine.dump_yaml(temp)
            end
            unless(aka.nil?)
                return "AKA Not Implemented Yet"
            end
            unless(yaml.nil?)
                return Yurl::Engine.pretty_print_yaml(yaml) if pp
                return Yurl::Engine.dump_yaml(yaml)
            end
            return "No YAML found for yurl to process"
        end
        def self.get(path, aka, pp, yaml_url)
            pp ||= false
            unless(path.nil?)
                haystack = Yurl::Engine.load_file(path)
                temp = Yurl::Engine.find(yaml_url, haystack)
                return Yurl::Engine.pretty_print_yaml(temp) if pp
                return Yurl::Engine.dump_yaml(temp)
            end
            unless(aka.nil?)
                return "AKA Not Implemented Yet"
            end
            return "No Values found at specified location - #{yaml_url}"
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