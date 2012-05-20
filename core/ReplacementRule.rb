require_relative "Common"
require_relative "ReplacementMatch"
require_relative "Rule"
require_relative "Token"

# ReplacementRules operate by lining up a pattern consisting of one or more
# Strings or Regexps to a list of Tokens. The result of this operation is
# an array of ReplacementMatches.
#
# The standard idiom here is to first initialize a new ReplacementRule,
# then call rule.require() for each String or Regexp in the pattern,
# and finally call rule.output_function() once to define the translation
# from pattern to result.
# 
#   rule = ReplacementRule.new("test")
#   rule.requires("word")
#   rule.requires(/expr(ess|ion)/, literal: true, reserved: false)
#   rule.has_output lambda { |word1, word2|
#     [Token.new(word2.text), Token.new(word1.text)]
#   }
#
# The above example would reverse any 2 tokens matching the pattern
# "word expr(ess|ion)". For instance, "word express" would become
# "express word".
class ReplacementRule < Rule
  
  # The array of Strings and Regexps to match with.
  attr_reader :pattern
  
  # An array of flags requirements.
  # Format is [[pattern index, symbol, true|false]]
  #
  # For instance, if the 2nd token must not be reserved,
  # requirements might be [[1, :reserved, false]].
  attr_reader :requirements
  
  # A lambda function taking as input an Array of ReplacementMatches
  # and outputting an Array of Tokens. This is called upon a successful match
  # to generate the Tokens which replace those originally matched.
  attr_reader :output_function_lambda
  
  # Default constructor.
  def initialize(name)
    super(name)
    @pattern = []
    @requirements = []
    @output_function_lambda = nil
  end
  
  # Adds a single token to the input pattern.
  # require("block")
  # requires precisely the string "block"
  # require("block", literal: true)
  # same, but block must be marked as literal
  # require("block", literal: false)
  # same, but block cannot be literal
  # require(/^\d+$/, ...)
  # regular expressions also welcome
  def requires(token_matcher, flags = nil)
    @pattern << token_matcher
    if token_matcher.is_a?(String)
      @requirements << [@pattern.count - 1, :not_reserved, false]
    end
    return self if flags == nil
    flags.each do |symbol, status|
      @requirements << [@pattern.count - 1, symbol, status]
    end
    self
  end
  
  # Sets output_function. See the member output_function for details.
  def has_output(output_function_lambda)
    @output_function_lambda = output_function_lambda
  end
  
  # Return the Set of alphabet-only String elements in the pattern.
  # More or less, this corresponds to the set of reserved words which are
  # processed as potentially something more than identifiers.
  def reserved_words()
    result = Set.new() 
    @pattern.each do |token_matcher|
      if token_matcher.is_a?(String) && token_matcher =~ Patterns::ALPHABET
        result.add(token_matcher)
      end
    end
    result
  end
  
  # Tries to match our pattern against a certain set of input tokens
  # at the given starting index. Assumes that a sufficient number of tokens
  # exists and does not check bounds.
  #
  # Returns Boolean: match found?, [ReplacementMatch]: the matches
  def try_match(tokens, begin_index)
    match_data = []
    
    @pattern.each_with_index do |rule, pattern_index|
      token = tokens[pattern_index + begin_index]
      
      # Check flags
      (@requirements.select {|r| r[0] == pattern_index}).each do |r|
        return false, nil if r[2] == true && !token.flagged?(r[1])
        return false, nil if r[2] == false && token.flagged?(r[1])
      end
      
      # Check text of rule
      if rule.is_a?(String)
        if rule.casecmp(token.text) == 0
          match_data << ReplacementMatch.new(token)
        else
          return false, nil
        end
      elsif rule.is_a?(Regexp)
        data = rule.match(token.text)
        if data != nil
          match_data << ReplacementMatch.new(token, data.to_a.drop(1))
        else
          return false, nil
        end
      end
    end
    
    return true, match_data
  end
  
  # Wraps the member @output_function_lambda so that it may be
  # overwritten by derived classes which provide their own canned output
  # functions.
  #
  # This implementation simply calls @output_function_lambda.
  def output_function(match_data)
    return @output_function_lambda.call(*match_data)
  end
  
  # Try to apply this ReplacementRule to the given Array of Tokens.
  # 
  # Returns replacement count, modified list of Tokens.  You may safely
  # assume that if no replacements were made the replacement count will be 0
  # and the modified list of Tokens will be unchanged from the original.
  def apply_to_tokens(tokens)
    begin_index = 0
    
    # Loop detection apparatus.
    total_replacements = 0
    maximum_replacements_allowed = tokens.count
    original_tokens = tokens
    
    while begin_index <= tokens.count - @pattern.count
      is_match, match_data = try_match(tokens, begin_index)
      if is_match
        # Apply rule
        replace_with = output_function(match_data)
        before = tokens[0, begin_index]
        after = tokens[begin_index + @pattern.count,
          tokens.count - begin_index - @pattern.count]
        tokens = before.concat(replace_with).concat(after)
        
        # Detect loops...
        total_replacements += 1
        if total_replacements > maximum_replacements_allowed
          puts "ERROR:  Potential infinite loop detected in..."
          puts self
          return 0, original_tokens
        end
      else
        # Only increment index if rule not applied
        begin_index += 1
      end
    end
    
    return total_replacements, tokens
  end
end
