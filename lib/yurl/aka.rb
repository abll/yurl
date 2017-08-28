# The Class To Handle Adding, Deleting and Modifying AkAs
module Yurl
  # Maybe Change This To A Config Variable
  AKA_PATH = '.aka.yaml'.freeze
  class AKA
    attr_accessor :aka_list
    def self.init_list(aka_file)
      unless File.exist?(aka_file)
        begin
            file = File.open(aka_file, 'w')
            file.write('AKA List: "Add Some AKAs"')
          rescue IOError => e
            return e.message
          ensure
            file.close unless file.nil?
          end
      end
      true
    end

    def self.load_list(aka_file)
      return 'Unable To Initalize AKA List' unless AKA.init_list(aka_file) == true
      yurl_object = Yurl::Engine.load_file(aka_file)
      return yurl_object unless (yurl_object.respond_to?(:has_key?))
      @aka_list = yurl_object
      @aka_list
    end

    def self.check_list(aka_file)
      return nil unless AKA.load_list(aka_file).respond_to?('each')
      true
    end

    def self.add(aka_file, aka_elem, path)
      return 'Error Adding To AKA List - Cannot Load List' unless
        AKA.check_list(aka_file) == true
      return "Error - Can't add Non YAML Files To AKA List" unless
        Yurl::Engine.check_load_params(path) == true
      return 'Aka Key Already Exists' if @aka_list.key?(aka_elem)
      @aka_list[aka_elem] = path
      AKA.save_list(aka_file)
      "Added AKA - #{aka_elem} with path #{path}"
    end

    def self.remove(aka_file, aka_elem)
      return 'Error Adding To AKA List - Cannot Load List' unless
        AKA.check_list(aka_file) == true
      return "Cannot find AKA #{aka_elem} in AKA List" unless
        @aka_list.key?(aka_elem)
      @aka_list.delete(aka_elem)
      AKA.save_list(aka_file)
      "Deleted AKA - #{aka_elem}"
    end

    def self.print_list(aka_file)
      return 'Error Printing List - Cannot Load List' if
        AKA.check_list(aka_file).nil?
      @aka_list
    end

    def self.save_list(aka_file)
      File.open(aka_file, 'w') do |file|
        file.write(Psych.dump(@aka_list))
      end
    rescue Exception => e
      return "Unhandled Exception #{e.class} Occurred"
    end

    def self.get_aka(aka_file, aka_elem)
      return 'Error Adding To AKA List - Cannot Load List' unless AKA.check_list(aka_file) == true
      return "Cannot find AKA #{aka_elem} in AKA List" unless @aka_list.key?(aka_elem.to_s)
      @aka_list[aka_elem]
    end

  end
end
