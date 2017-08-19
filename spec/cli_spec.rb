require 'spec_helper'

RSpec.describe Yurl::CLI, :type => :aruba do
    it 'can print Hello World' do
        run_simple('yurl hello')
        expect(last_command_started).to have_output "Hello World!!"
    end

    it 'can dump yaml passed to it' do
        run_simple('yurl dump "Test Yaml Dump: Its Dumped"')
        expect(last_command_started.output).to include "Test Yaml Dump:"
    end
    
end