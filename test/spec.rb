require_relative 'test_init'

Runner.! 'spec/command/*.rb' do |exclude|
  exclude =~ /_init.rb\z/
end
