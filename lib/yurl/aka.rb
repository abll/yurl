#The Class To Handle Adding, Deleting and Modifying AkAs
module Yurl
    class AKA
        attr_accessor :aka_hash
        def initialize
            @aka_hash = Hash.new
        end

        def add(aka, path)
            #Check File Exists At Path

            #Add File To Hash Array
        end

        def remove(aka)
            #Remove From Hash
        end

        def edit_path(aka, new_path)
        end

        def edit_aka(aka, new_aka)
            #Add new aka with path at old aka. 
            
            #Remove From Path
        end

        def list
            @aka_hash
        end

        def get_aka(aka)
            unless @aka_hash[aka].nil
                return "No AKA Found With Name - #{aka}"
            end
            @aka_hash[aka]
        end

    end
end