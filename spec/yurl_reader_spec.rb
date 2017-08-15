require 'spec_helper'

RSpec.describe Yurl::YurlReader do
  let(:needle_string) { 'Test Nested Secrets/Nested Secret/Super Nested Secret/username' }
  let(:test_val) { Yurl::YurlReader.new('spec/helpers/dummy.yml') }
  let(:param) { Yurl::YurlReader.process_query_string('Test Nested Secrets/Nested Secret/Super Nested Secret/username') }
  let(:non_param) { Yurl::YurlReader.process_query_string('Test Nested Secrets/Nested Secret/Super Nested Secret/usernames') }

  it 'constructor instantiates instance variables' do
    expect(test_val.file_name).to be_instance_of(String)
    expect(test_val.secret_ruby).to respond_to('each')
  end

  ################### Test Class Level Methods ######################

  it 'can load a yaml file' do
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

  it 'can search a hash for a parameter' do
    in_arr = Yurl::YurlReader.find_internal('Nonested Secrets', test_val.secret_ruby)
    out_arr = Yurl::YurlReader.find_internal('Nonested Secret', test_val.secret_ruby)
    non_assoc_arr = Yurl::YurlReader.find_internal('username', param)

    expect(in_arr).to be_instance_of(String)
    expect(out_arr).to eq(nil)
    expect(non_assoc_arr).to eq(nil)
  end

  it 'can find a nested element given an array' do
    nested_arr = Yurl::YurlReader.find_nested(param, test_val.secret_ruby)
    non_nested_arr = Yurl::YurlReader.find_nested(non_param, test_val.secret_ruby)
    
    expect(nested_arr).to eq('bestdeveever')
    expect(non_nested_arr).to eq(nil)
  end

  it 'can find a nested element given a string' do
    test = Yurl::YurlReader.find('Test Nested Secrets/Nested Secret', test_val.secret_ruby)
    test2 = Yurl::YurlReader.find('Test Nested Secrets/Nested Secret/', test_val.secret_ruby)
    test3 = Yurl::YurlReader.find('Test Nested Secrets/Nested Secrets', test_val.secret_ruby)
    
    expect(test).to be_instance_of(Hash)
    expect(test['username']).to eq('gothere')
    expect(test['username']).to eq(test2['username'])
    expect(test3).to include('Parameter Not Found At Path')
  end

  it 'can dump the yaml hash' do
    dumped_yaml = Yurl::YurlReader.dump_yaml(test_val.secret_ruby)
    expect(dumped_yaml).to be_instance_of(Hash)
  end

  it 'can pretty print the yaml class' do
    pretty_yaml = Yurl::YurlReader.pretty_print_yaml(test_val.secret_ruby)
    expect(pretty_yaml).to be_instance_of(String)
  end
end
