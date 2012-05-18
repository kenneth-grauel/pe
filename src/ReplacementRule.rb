require_relative "Common"
require_relative "ReplacementMatch"
require_relative "Rule"
require_relative "Token"

# Almost every rule will be of this class or a subclass thereof.
# This class implements the standard pattern replacement technique:
# Match a list of tokens as strings or regexps in the input
# and replace them with output generated from the matches.
# Basically a large pattern substitution.
# 
# A ReplacementRule is defined by a pattern and a result.
# The pattern is an array of token matchers, either strings or regexps.
class ReplacementRule < Rule
  
  attr_reader :pattern, :requirements, :output_function, :match_data
  
  def initialize(name)
    super(name)
    @pattern = []
    @requirements = []
    @output_function = nil
    @match_data = nil
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
  
  def has_output(output_function)
    @output_function = output_function
  end
  
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
  # Returns true or false: was a match found?
  # Side effect: sets @match_data in the following format:
  #   [ReplacementMatch]
  def matches?(tokens, begin_index)
    @match_data = []
    temp_match_data = []
    
    @pattern.each_with_index do |rule, pattern_index|
      token = tokens[pattern_index + begin_index]
      
      # Check flags
      (@requirements.select {|r| r[0] == pattern_index}).each do |r|
        return false if r[2] == true && !token.flagged?(r[1])
        return false if r[2] == false && token.flagged?(r[1])
      end
      
      # Check text of rule
      if rule.is_a?(String)
        if rule.casecmp(token.text) == 0
          temp_match_data << ReplacementMatch.new(token)
        else
          return false
        end
      elsif rule.is_a?(Regexp)
        data = rule.match(token.text)
        if data != nil
          temp_match_data << ReplacementMatch.new(token, data.to_a.drop(1))
        else
          return false
        end
      end
    end
    
    @match_data = temp_match_data
    true
  end
  
  # This is defined separately so it may be overridden by derived classes
  def output_function(match_data)
    return @output_function.call(*match_data)
  end
  
  def apply_to_tokens(tokens)
    begin_index = 0
    
    # Loop detection apparatus.
    total_replacements = 0
    maximum_replacements_allowed = tokens.count
    original_tokens = tokens
    
    while begin_index <= tokens.count - @pattern.count
      if matches?(tokens, begin_index)
        # Apply rule
        replace_with = output_function(@match_data)
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
