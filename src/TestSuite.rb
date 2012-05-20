# Traditional unit testing is just a bit too much for me,
# so consider this my ad hoc solution.
class TestCase
  attr_reader :description, :input, :output
  attr_reader :result, :details, :actual_output
  attr_reader :language_context
  
  # Construct a TestCase.
  # Requires a description, input, and output at construction time,
  # and the resulting TestCase is immutable.
  def initialize(description, input, output, language_context)
    @description = description
    @input = input
    @output = output
    @language_context = language_context
  end
  
  # Execute the TestCase.
  # Returns result, details
  # Result is Boolean: passed or not?
  # Details is a String or other printable object.
  def run()
    @actual_output = SpeechProcessor.convert_to_code(@input, @language_context)
    
    code_no_white = @actual_output.gsub(/\s+/, "")
    output_no_white = @output.gsub(/\s+/, "")
    content_distance = Levenshtein.distance(code_no_white, output_no_white)
    
    code_white = @actual_output.gsub(/\S+/, "")
    output_white = @output.gsub(/\S+/, "")
    white_distance = Levenshtein.distance(code_white, output_white)
    
    if @actual_output == @output
      @result = true
      @details = ""
    else
      @result = false
      if @actual_output.casecmp(@output) == 0
        @details = "Case wrong, everything else OK"
      elsif white_distance == 0
        @details = "Content wrong (distance #{content_distance}), whitespace OK"
      elsif content_distance == 0
        @details = "Whitespace wrong (distance #{white_distance}), content OK"
      else
        @details = "Content and whitespace wrong " +
          "(distance #{content_distance} cont, #{white_distance} white)"
      end
    end
    
    return @result, @details
  end
  
  # Convert to string.
  # If verbose, include the input/output strings.
  # If do_test, run the test on the spot and output it as well.
  def to_s(verbose = false, do_test = false)
    string = @description + " (TestCase: " + @language_context.name + ")"
    
    if do_test
      run()
      if @result == true
        string = "  OK: ".green_bold + string.green_bold
      else
        string = "FAIL: ".yellow_bold + string.yellow_bold
        if verbose
          if !@details.empty?
            string << ("\n      " + @details).white
          end
          string << "\n         Input: " + @input.white
          string << "\n        Output: " + @actual_output.yellow_bold.on_red
          string << "\n      Expected: " + @output.cyan_bold.on_blue
        end
      end
    end
    
    if verbose && !do_test
      string << "\n       Input: \"" + @input + "\""
      string << "\n      Output: \"" + @output + "\""
    end
    
    string
  end
end

# A collection of tests.
class TestSuite
  attr_accessor :tests, :language_context
  
  # Initialize this TestSuite from the given file.
  # Take a look at testpairs.rb to see the syntax.
  def initialize(filename, language_context)
    @tests = []
    @language_context = language_context
    if filename != nil
      load_from_file filename
    end
  end
  
  # Load test cases from the given file and append them to this test suite.
  # The format is pretty much: 
  # "# description"
  # "#: speech input"
  # "code output"
  # repeated as many times as preferred. Note that whitespace is relevant
  # in both the input and output!
  def load_from_file(filename)
    description = ""
    input = ""
    output = ""
    
    File.open(filename, "r") do |file|
      while (line = file.gets)
        line.chomp!
        if line =~ /^\#\: (.*)/   # Input    "#: <input>"
          if !input.empty?
            input << "\n"
          end
          input << $1
        elsif line =~ /^\# (.*)/  # Description   "# <desc>"
          if !description.empty? && !input.empty? && !output.empty?
            tests << TestCase.new(description, input, output, @language_context)
            description = ""
            input = ""
            output = ""
          end
          if !description.empty?
            description << "\n"
          end
          description << $1
        else                    # Output    "<output>"
          if !output.empty?
            output << "\n"
          end
          output << line
        end
      end # while
      if !description.empty? && !input.empty? && !output.empty?
        tests << TestCase.new(description, input, output, @language_context)
      end
    end # File.open
  end # load_from_file
  
  # Display the test cases in this test suite.
  # By default, this actually executes all of the tests.
  def run_tests(verbose = true, do_test = true)
    puts "\nRunning #{tests.count} tests:\n".magenta_bold
    pass = 0
    fail = 0
    tests.each do |test|
      result_text = test.to_s(verbose, do_test)
      if test.result
        pass += 1
        puts result_text if Settings::TESTSUITE_DISPLAY_OK
      else
        fail += 1
        puts result_text
        if Settings::TESTSUITE_STOP_AT_ERROR
          break
        end
      end
    end
    print "\n    TOTAL: " + pass.to_s.green_bold + " pass".green
    if fail > 0
      print ", " + fail.to_s.yellow_bold + " fail".yellow
    end
    print "\n\n"
  end
  
end