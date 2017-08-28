# Class File To Implement Yurl Engine
require 'psych'
require 'pp'

module Yurl
  class Engine
    attr_accessor :secret_ruby, :file_name

    ######################################### Instance Variables ##########################################

    # Constructor for Engine Class
    def initialize(yml_file)
      @file_name = yml_file
      @secret_ruby = Engine.load_file(yml_file)
    end

    # Method To Find Nodes With Specific Values
    def find(query)
      query_list = Engine.process_query_string(query)
      ret = find_nested(query_list)
      return "Parameter Not Found At Path - #{query}" if ret.nil?
      ret
    end

    ################################ Class Methods #################################

    # Method to Follow String to Yaml Node.
    def self.find(needle_string, haystack)
      query_list = Engine.process_query_string(needle_string)
      ret_val = Engine.find_nested(query_list, haystack)
      return "Parameter Not Found At Path - #{needle_string}" if ret_val.nil?
      ret_val
    end

    # Method To Follow Array Path To Find Yaml Target
    def self.find_nested(needle_array, haystack)
      ret_val = haystack
      loop do
        param = needle_array.pop
        break if ret_val.nil? || param.nil?
        ret_val = Engine.find_internal(param, ret_val)
      end
      ret_val
    end

    # Method To Check If Param Is A Key In The Array
    def self.find_internal(param, hash)
      return nil unless hash.class == Hash && !hash[param].nil?
      hash[param]
    end

    # Method to Parse Query List in Query Array
    def self.process_query_string(needle)
      query_list = needle.split('/')
      raise ArgumentError, 'Query String In Wrong Format' unless query_list.respond_to?('each')
      query_list.reverse
    end

    # Self File Loader For Engine Class
    # Need to put in logic about an empty yaml file / non - existent YAML File
    def self.load_file(yml_file)
      file_check = Engine.check_load_params(yml_file)
      return file_check unless file_check == true
      Psych.parse_file(yml_file).to_ruby
    end

    # Loading Yaml From Directly Passed Yaml Text
    def self.load_yaml(yml)
      raise ArgumentError, 'Attempted To Process Null Object' if yml.nil?
      ret_val = Psych.parse(yml).to_ruby
      ret_val
    end

    # Dump The Yaml File - Yaml to Hash
    def self.dump_yaml(yaml_hash)
      yaml_hash
    end

    # Pretty Print The YAML File - Yaml To String
    def self.pretty_print_yaml(yaml_hash)
      yaml_hash.pretty_inspect
    end

    def self.check_load_params(yml_file)
      begin
        raise ArgumentError, 'Attempted To Process Nil File Object' if yml_file.nil?
        raise ArgumentError, 'Attempted To Process Non YAML File' unless (File.extname(yml_file) == '.yml') || (File.extname(yml_file) == '.yaml')
        raise IOError, 'Attempted To Process Non-Existent YAML File' unless File.exist?(yml_file)
        raise ArgumentError, 'Attempted To Process Empty YAML File' if Psych.parse_file(yml_file).to_ruby == false
      rescue StandardError => e
        return "Exception raised with message - #{e.message}"
      end
      true
    end
  end
end
