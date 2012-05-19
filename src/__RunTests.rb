# 

require_relative "Common"
require_relative "SpeechProcessor"
require_relative "TestSuite"
require_relative "RubyContext"

suite = TestSuite.new("__UnitTests.rb", RubyContext.instance)
suite.run_tests

while true
  print "\n> "
  line = STDIN.gets.chomp
  if line == ""
    break
  end
  result = SpeechProcessor.convert_to_code(line, RubyContext.instance)
  puts "Result: " + result
end


