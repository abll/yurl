# Class File To Implement Yurl_Reader
require 'psych'
require 'pp'

module Yurl
    class YurlReader
        attr_accessor :secret_ruby, :file_name

        ######################################### Instance Variables ##########################################

        # Constructor for YurlReader Class
        def initialize(yml_file)
            @file_name = yml_file
            @secret_ruby = YurlReader.load_file(yml_file)
        end
        
        # Method To Find Nodes With Specific Values
        def find(query)
            query_list = YurlReader.process_query_string(query)
            ret = self.find_nested(query_list)
            if ret.nil?
                return "Parameter Not Found At Path - #{query}"
            end
            ret
        end

        ################################ Class Methods #################################

        def self.find_nested(query_array, source_array)
            ret_val = source_array
            loop do
                param = query_array.pop
                break if ( ret_val.nil? || param.nil?)
                ret_val = YurlReader.find_internal(param, ret_val)
            end
            ret_val
        end

         # Method To Check If Param Is A Key In The Array
        def self.find_internal(param, array)
            return nil unless (array.respond_to?('each'))
            if(array[param].nil?)
                return nil
            else
                array[param]
            end
        end
        
        # Method to Parse Query List in Query Array 
        def self.process_query_string(query_string)
            puts query_string
            query_list = query_string.split('/')
            raise ArgumentError, 'Query String In Wrong Format' unless query_list.respond_to?('each')
            pp query_list
            query_list.reverse
        end

        # Self File Loader For YurlReader Class
        # Need to put in logic about an empty yaml file
        def self.load_file(yml_file)
            raise ArgumentError, 'Attempted To Process Null Object' if yml_file.nil?
            raise ArgumentError, 'Attempted To Process Non YAML File' unless ((File.extname(yml_file) == '.yml') || (File.extname(yml_file) == '.yaml'))
            @file_name = yml_file
            Psych.parse_file(yml_file).to_ruby
        end

        # Loading Yaml From Directly Passed Yaml Text
        def self.load_yaml(yml)
            raise ArgumentError, 'Attempted To Process Null Object' if (yml.nil?)
            psych_yml = Psych.parse(yml)
            @secret_ruby = psych_yml.to_ruby
        end

        # Dump The Yaml File
        def self.dump_yaml
            puts "YAML Dump Of - #{@file_name}"
            puts @secret_ruby
        end

        # Pretty Print The YAML File
        def self.pretty_print_yaml
            puts "Pretty Print The YAML Dump - #{@file_name}"
            pp @secret_ruby 
        end
       
    end
end

=begin

        def initialize(yml_file)
            raise ArgumentError, 'Attempted To Process Null Object' if (yml_file.nil?)
            raise ArgumentError, 'Attempted To Process Non YAML File' unless ((File.extname(yml_file) == '.yml') || (File.extname(yml_file) == '.yaml'))
            @file_name = yml_file
            @secret_ruby = File.open(yml_file)
            #@secret_ruby = Psych.parse_file(yml_file).to_ruby
            #@secret_ruby = "Psych.methods"
            #self.secret_ruby = Psych.parse_file
            puts @secret_ruby
        end


            # Method To Check If Param Is A Key In The Array
        def find_internal(param, array)
            return nil unless (array.respond_to?('each'))
            
            if(array[param].nil?)
                return nil
            else
                return array[param]
            end

                    # Method To Cycle Through Query Array And Ruby Object Of The Yaml
        def find_nested(query_array)
            ret_val = @secret_ruby
            loop do
                param = query_array.pop
                break if ((ret_val.nil?) || (param.nil?))
                ret_val = YurlReader.find_internal(param, ret_val)
            end
            ret_val
        end

        def self.find_internal(param, array)
            return nil unless ( array.respond_to?('each') || !array[param].nil? )
            
            array[param]

        end
        end
=end