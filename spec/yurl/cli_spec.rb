require 'spec_helper'

RSpec.describe Yurl::CLI, type: :aruba do
  it 'can print Hello World' do
    run_simple('yurl hello')
    expect(last_command_started).to have_output 'Hello World!!'
  end

  it 'can dump yaml passed to it' do
    run_simple('yurl dump "Test Yaml Dump: Its Dumped"')
    expect(last_command_started.output).to include 'Test Yaml Dump:'
  end

  it 'can find a value given a path and query string' do
    run_simple('yurl get --path=../../spec/yurl/helpers/dummy.yml "Test Nested Secrets/username"')
    expect(last_command_started.output).to eq("baddeveloper\n")
  end

  it 'does not return false positive results' do
    run_simple('yurl get --path=../../spec/yurl/helpers/dummy.yml "Test Nested Secrets/usernames"')
    expect(last_command_started.output).to include 'Parameter Not Found At Path'
  end
end
