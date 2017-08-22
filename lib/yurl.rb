require "yurl/version"
require "yurl/aka"

module Yurl
  class << self
    attr_accessor :aka
  end

  def self.load_aka()
    @aka ||= AKA.new
  end
  # Your code goes here...
end
