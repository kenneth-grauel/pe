require_relative "Common"
require_relative "ReplacementRule"

# A simple rule which marks the following token with a certain flag.
# These are typically used at the beginning of the processing to influence
# the following steps.
class FlagRule < ReplacementRule
  
  # Match one or more tokens by flag_text (separate tokens by spaces), and
  # process by adding flag_symbol to the following token and prefixing the
  # following token with append.
  def initialize(flag_text, flag_symbol, append = "")
    super(flag_text + " flag")
    @flag_symbol = flag_symbol
    @append = append
    flag_text.split.each do |text|
      requires text.downcase
    end
    requires(Patterns::ANYTHING)
  end
  
  # Apply this rule to a given match_data.
  def output_function(match_data)
    result_text = @append + match_data[-1].text
    result_flags = match_data[-1].flags
    result_flags.add(@flag_symbol)
    return [Token.new(result_text, result_flags)]
  end
end


# A simple rule which corrects for misspellings of the "at <number>" pattern.
# For example, the user may enter something like “at four" or "at to" and really
# mean "at 4" or "at 2".
class AtNumberMisspellingRule < ReplacementRule
  
  # Match the pattern “at encryption_word”, and output “at replacement”.
  # The replacement should be a number.
  def initialize(name, incorrect_word, replacement)
    super(name)
    @replacement = replacement
    requires Patterns::ANYTHING, literal: true
    requires "at"
    requires incorrect_word, literal: true, reserved: false
  end
  
  # Apply this rule to a given match_data.
  def output_function(match_data)
    [match_data[0].token,
     match_data[1].token,
     Token.new(@replacement, :numeric)]
  end
end


# A simple rule which matches a certain verbatim string of input and replaces it
# with another verbatim string of output. The resulting output is flagged reserved.
class KeywordRule < ReplacementRule
  
  # Replace spoken with code.
  # Spoken and code may both consist of multiple words separated by spaces.
  # In this case, multiple tokens will be matched or created (respectively).
  def initialize(spoken, code, *additional_flags)
    super(spoken + " keyword")
    spoken.split.each do |word|
      requires word, literal: true
    end
    @code = code.split
    @additional_flags = additional_flags
  end
  
  # Apply this rule to a given match_data.
  def output_function(match_data)
    output = []
    @code.each do |keyword|
      token = Token.new(keyword, :reserved)
      @additional_flags.each do |flag|
        token.set_flag flag
      end
      output << token
    end
    output
  end
  
end