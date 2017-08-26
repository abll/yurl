#The Class To Handle Adding, Deleting and Modifying AkAs
module Yurl
    class AKA
        attr_accessor :aka_list
        def self.init_list(aka_file)
            unless File.exists?(aka_file)
                begin
                    file = File.open(aka_file, "w")
                    file.write('AKA List: "Add Some AKAs"') 
                rescue IOError => e
                    return e.message
                ensure
                    file.close unless file.nil?
                end
            end
            return true
        end

        def self.load_list(aka_file)
            return "Unable To Initalize AKA List" unless (AKA.init_list(aka_file) == true)
            begin
                @aka_list = Yurl::Engine.load_file(aka_file)
            rescue ArgumentError => e
                return e.message
            rescue Exception => e
                return "Unhandled Exception #{e.class} Occurred"
            end
            @aka_list
        end

        def self.check_list(aka_file)
            return nil unless AKA.load_list(aka_file).respond_to?('each')
            true
        end

        def self.add(aka_file, aka_elem, path)
            return "Error Adding To AKA List - Cannot Load List" unless AKA.check_list(aka_file) == true
            # Validates Path Leads To Yaml
            #Yurl::Engine.check_load_params(path)
            # Check If Key Already Exists in AKA
            return "Aka Key Already Exists" if @aka_list.key?(aka_elem)
            # Add File To Hash Array
            @aka_list[aka_elem] = path
            AKA.save_list(aka_file)
            return "Added AKA - #{aka_elem} with path #{path}"
        end

        def self.remove(aka_file, aka_elem)
            return "Error Adding To AKA List - Cannot Load List" unless AKA.check_list(aka_file) == true
            return "Cannot find AKA #{aka_elem} in AKA List" unless @aka_list.key?(aka_elem)
            @aka_list.delete(aka_elem)
            AKA.save_list(aka_file)
            return "Deleted AKA - #{aka_elem}"          
        end

        def self.print_list(aka_file)
            return "Error Printing List - Cannot Load List" if AKA.check_list(aka_file).nil?
            @aka_list
        end

        def self.save_list(aka_file)
            begin
                File.open(aka_file, 'w') do |file|
                    file.write(Psych.dump(@aka_list))
                end
            rescue Exception => e
                return "Unhandled Exception #{e.class} Occurred"
            end
        end
    end
end