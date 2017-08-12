require "spec_helper"

RSpec.describe Yurl::YurlReader do
  let(:test_val) { Yurl::YurlReader.parse_file("spec/helpers/dummy.yml") }
  it "loads a yaml file" do
    expect(test_val.secret_ruby).to be_an_instance_of(Hash)
  end
end