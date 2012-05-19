require_relative "Common"
require_relative "SpeechProcessor"
require_relative "TestSuite"
require_relative "RubyContext"

# Run the standard test suite.
suite = TestSuite.new("__UnitTests.rb", RubyContext.instance)
suite.run_tests

# When finished, accepts interactive input from the console.
# Converts speech into code, context-free, line by line.
while true
  print "\n> "
  line = STDIN.gets.chomp
  if line == ""
    break
  end
  result = SpeechProcessor.convert_to_code(line, RubyContext.instance)
  puts "Result: " + result
end


