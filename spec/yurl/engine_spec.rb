require 'spec_helper'

RSpec.describe Yurl::Engine do
  let(:needle_string) { 'Test Nested Secrets/Nested Secret/Super Nested Secret/username' }
  let(:test_val) { Yurl::Engine.new('spec/yurl/helpers/dummy.yml') }
  let(:param) { Yurl::Engine.process_query_string('Test Nested Secrets/Nested Secret/Super Nested Secret/username') }
  let(:non_param) { Yurl::Engine.process_query_string('Test Nested Secrets/Nested Secret/Super Nested Secret/usernames') }

  it 'constructor instantiates instance variables' do
    expect(test_val.file_name).to be_instance_of(String)
    expect(test_val.secret_ruby).to respond_to('each')
  end

  ################### Test Class Level Methods ######################

  it 'can load a YAML/YML file' do
    test_file = Yurl::Engine.load_file('spec/yurl/helpers/dummy.yml')
    expect(test_file).to respond_to('each')
    yaml_file = double(File, filename: 'mock.yaml')
    temp = Yurl::Engine.load_file(yaml_file.filename)
    expect(temp).to be_instance_of(String)
    expect(temp).to include('Non-Existent YAML File')
  end

  it 'throws an error when non yaml file passed' do
    non_yaml_file = double(File, filename: 'mock.txt')
    temp = Yurl::Engine.load_file(non_yaml_file.filename)
    expect(temp).to be_instance_of(String)
    expect(temp).to include('Non YAML File')
  end

  it 'parses directly passed yaml' do
    test_yaml = Yurl::Engine.load_yaml("---\n - Test Yaml\n - More Yaml")
    expect(test_yaml).to respond_to('each')
  end

  it 'handles a non-existent file being passed to load' do
    temp = Yurl::Engine.load_file('doesntExist.yml')
    expect(temp).to be_instance_of(String)
    expect(temp).to include('Non-Existent YAML File')
  end

  # Need To Mock Empty YAML File - Need To Implement Better Spec
  it 'throws an error when an empty YAML file passed' do
    # File.stub!(:exists?).and_return(true)
    empty_file = double(File, filename: 'mock.yaml')
    temp = Yurl::Engine.load_file(empty_file.filename)
    expect(temp).to be_instance_of(String)
    expect(temp).to include('Non-Existent YAML File')
  end

  it 'parses string yaml path to param array' do
    expect(param).to respond_to('each')
    expect(param.length).to eq(4)
    expect(param[0]).to eq('username')
  end

  it 'can search a hash for a parameter' do
    in_arr = Yurl::Engine.find_internal('Nonested Secrets', test_val.secret_ruby)
    out_arr = Yurl::Engine.find_internal('Nonested Secret', test_val.secret_ruby)
    non_assoc_arr = Yurl::Engine.find_internal('username', param)

    expect(in_arr).to be_instance_of(String)
    expect(out_arr).to eq(nil)
    expect(non_assoc_arr).to eq(nil)
  end

  it 'can find a nested element given an array' do
    nested_arr = Yurl::Engine.find_nested(param, test_val.secret_ruby)
    non_nested_arr = Yurl::Engine.find_nested(non_param, test_val.secret_ruby)

    expect(nested_arr).to eq('bestdeveever')
    expect(non_nested_arr).to eq(nil)
  end

  it 'can find a nested element given a string' do
    test = Yurl::Engine.find('Test Nested Secrets/Nested Secret', test_val.secret_ruby)
    test2 = Yurl::Engine.find('Test Nested Secrets/Nested Secret/', test_val.secret_ruby)
    test3 = Yurl::Engine.find('Test Nested Secrets/Nested Secrets', test_val.secret_ruby)

    expect(test).to be_instance_of(Hash)
    expect(test['username']).to eq('gothere')
    expect(test['username']).to eq(test2['username'])
    expect(test3).to include('Parameter Not Found At Path')
  end

  it 'can dump the yaml hash' do
    dumped_yaml = Yurl::Engine.dump_yaml(test_val.secret_ruby)
    expect(dumped_yaml).to be_instance_of(Hash)
  end

  it 'can pretty print the yaml class' do
    pretty_yaml = Yurl::Engine.pretty_print_yaml(test_val.secret_ruby)
    expect(pretty_yaml).to be_instance_of(String)
  end
end
