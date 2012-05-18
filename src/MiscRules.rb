require_relative "Common"
require_relative "ReplacementRule"

class FlagRule < ReplacementRule
  
  # When flag_text shows up in the input, flag the FOLLOWING TOKEN with
  # flag_symbol.
  def initialize(flag_text, flag_symbol, append = "")
    super(flag_text + " flag")
    @flag_symbol = flag_symbol
    @append = append
    flag_text.split.each do |text|
      requires text.downcase
    end
    requires(Patterns::ANYTHING)
  end
  
  def output_function(match_data)
    result_text = @append + match_data[-1].text
    result_flags = match_data[-1].flags
    result_flags.add(@flag_symbol)
    return [Token.new(result_text, result_flags)]
  end
end

class AtNumberMisspellingRule < ReplacementRule
  
  def initialize(name, incorrect_word, replacement)
    super(name)
    @replacement = replacement
    requires Patterns::ANYTHING, literal: true
    requires "at"
    requires incorrect_word, literal: true, reserved: false
  end
  
  def output_function(match_data)
    [match_data[0].token,
     match_data[1].token,
     Token.new(@replacement, :numeric)]
  end
end

class KeywordRule < ReplacementRule

  # Verbatim text-to-text replacement of one or more spoken text words
  # with code. As simple as it gets.
  def initialize(spoken, code)
    super(spoken + " keyword")
    spoken.split.each do |word|
      requires word, literal: true
    end
    @code = code.split
  end
  
  def output_function(match_data)
    output = []
    @code.each do |keyword|
      output << Token.new(keyword, :reserved)
    end
    output
  end
  
end