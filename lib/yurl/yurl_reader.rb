#Class File To Implement Yurl_Reader
require "psych"

module Yurl
    class YurlReader
        attr_accessor :secret_ruby, :file_name

        def self.parse_file(file_name)
            Psych.parse_file(file_name)
        end
        
        # File Loader For YurlReader Class
        def self.load_file(yml_file)
            raise ArgumentError, 'Attempted To Process Null Object' if (yml_file.nil?)
            raise ArgumentError, 'Attempted To Process Non YAML File' unless ((File.extname(yml_file) == '.yml') || (File.extname(yml_file) == '.yaml'))
            
            @file_name = yml_file
            #@secret_ruby = Psych.parse_file(yml_file).to_ruby
            @secret_ruby = Psych.methods
            puts @secret_ruby
        end

        # Loading Yaml From Directly Passed Yaml Text
        def self.load_yaml(yml)
            raise ArgumentError, 'Attempted To Process Null Object' if (yml.nil?)

            @file_name = "Directly Passed Yaml Text"
            psych_yml = parse(yml)
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

        # Method to Parse Query List in Query Array 
        def process_query_string(query_string)
            query_list = query_string.split('/')
            raise ArgumentError, 'Query String In Wrong Format' unless (query_string.respond_to?('each'))
            return query_list.reverse
        end

        # Method To Find Nodes With Specific Values
        def find(query)
            query_list = self.process_query_string(query)
            ret = self.find_nested(query_list)
            if ret.nil?
                return "Parameter Not Found At Path - #{query}"
            end
            return ret
        end

        # Method To Check If Param Is A Key In The Array
        def find_internal(param, array)
            return nil unless (array.respond_to?('each'))
            
            if(array[param].nil?)
                return nil
            else
                return array[param]
            end
        end

        # Method To Cycle Through Query Array And Ruby Object Of The Yaml
        def find_nested(query_array)
            ret_val = @secret_ruby
            loop do
                param = query_array.pop
                break if((ret_val.nil?) || (param.nil?))
                ret_val = self.find_internal(param, ret_val)
            end
            return ret_val
        end
    end
end