require 'spec_helper'

RSpec.describe Yurl::YurlReader do
  let(:test_val) { Yurl::YurlReader.new('spec/helpers/dummy.yml') }
  let(:param) { Yurl::YurlReader.process_query_string('Test Nested Secrets/Nested Secret/Super Nested Secret/username') }
  it 'constructor instantiates instance variables' do
    expect(test_val.file_name).to be_instance_of(String)
    expect(test_val.secret_ruby).to respond_to('each')
  end

  ################### Test Class Level Methods ######################

  it 'can load an yaml file' do
    test_file = Yurl::YurlReader.load_file('spec/helpers/dummy.yml')
    expect(test_file).to respond_to('each')
  end

  # Need to Mock opening non yaml file
  it 'throws an error when non yaml file passed' do
    expect(true).to eq(true)
  end

  it 'parses directly passed yaml' do
    test_yaml = Yurl::YurlReader.load_yaml("---\n - Test Yaml\n - More Yaml")
    expect(test_yaml).to respond_to('each')
  end

  it 'parses string yaml path to param array' do
    expect(param).to respond_to('each')
    expect(param.length).to eq(4)
    expect(param[0]).to eq('username')
  end

  it 'can search an array for a parameter' do
    in_arr = Yurl::YurlReader.find_internal('Nonested Secrets', test_val.secret_ruby)
    out_arr = Yurl::YurlReader.find_internal('Nonested Secret', test_val.secret_ruby)
    #non_assoc_arr = Yurl::YurlReader.find_internal('username', param)

    expect(in_arr).to be_instance_of(String)
    expect(out_arr).to eq(nil)
  end
end

