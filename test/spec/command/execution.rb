require_relative 'command_init'
require 'minitest/autorun'

module Execution
  class Example
    include Command

    attr_reader :executed

    def !
      @executed = true
    end
  end
end

describe "A Command" do
  specify "Executes" do
    cmd = Execution::Example.build

    cmd.!

    assert(cmd.executed == true)
  end
end
