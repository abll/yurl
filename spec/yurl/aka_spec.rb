require 'spec_helper'

RSpec.describe Yurl::AKA do
  let(:aka_file) { 'spec/yurl/helpers/.aka.yml' }
  it 'can init an aka file' do
    temp = Yurl::AKA.init_list(aka_file)
    expect(temp).to eq(true)
    expect(File.exist?(aka_file)).to eq(true)
  end

  it 'can load the aka file' do
    temp = Yurl::AKA.load_list(aka_file)
    expect(temp).to be_instance_of(Hash)
  end

  it 'can check an aka file' do
    expect(Yurl::AKA.check_list(aka_file)).to eq(true)
  end

  it 'doesnt add NON YAML file to aka lost' do
    temp = Yurl::AKA.add(aka_file, 'Aka Entry 3', 'spec/yurl/helpers/.aka.text')
    expect(temp).to include("Can't add Non YAML")
  end

  it 'can add an aka to aka file' do
    temp = Yurl::AKA.add(aka_file, 'Aka Entry 2', 'spec/yurl/helpers/.aka.yml')
    expect(temp).to include('Added AKA')
  end

  it 'can remove an aka from aka file' do
    temp = Yurl::AKA.remove(aka_file, 'Aka Entry 2')
    expect(temp).to include('Deleted AKA')
  end

  it 'can retrieve an aka from aka list' do
    temp = Yurl::AKA.get_aka(aka_file, 'AKA List')
    expect(temp).to eq('Add Some AKAs')
  end
end
