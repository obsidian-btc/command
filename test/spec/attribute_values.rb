require_relative 'spec_init'
require 'minitest/autorun'

module AttributeValues
  class Example
    include Command

    attr_accessor :some_attribute
    attr_accessor :some_other_attribute
  end

  def self.data
    {
      some_attribute: 'some value',
      some_other_attribute: 'some other value'
    }
  end
end

describe "Attribute values" do
  it "Are transfered to the command via a data hash" do
    data = AttributeValues.data
    cmd = AttributeValues::Example.build data

    assert(cmd.some_attribute == data[:some_attribute])
    assert(cmd.some_other_attribute == data[:some_other_attribute])
  end
end
