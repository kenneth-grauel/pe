require_relative "Common"
require_relative "LanguageContext"
require_relative "SharedRules"

class RubyContext < LanguageContext
  include Singleton
  
  def initialize()
    super("Ruby")
    @rulebook = Rulebook.new(@name)
    
    # Flags
    add_rules SharedRules.get(
      :identifier, :all_upper, :upper, :lower,
      :hex_literal, :binary_literal, :octal_literal, :character_literal,
      :followed_by,
      :under_underscores, :under_concatenate, :camel_case,
      :class_case, :upper_underscores, :upper_concatenate
    )
    
    # At-notation
    add_rules SharedRules.get(
      :at_1, :at_2a, :at_2b, :at_3, :at_4a, :at_4b, :at_5,
      :at_6, :at_7, :at_8, :at_9, :at_notation
    )
    
    # Concatenations
    add_rules SharedRules.get(
      :identifier_weird_endings,
      :hex_concatenation, :unary_minus_before_numeric,
      :underscores_within_integers, :with_exponent
    )
    
    # Conversions
    conversions = [
      ["member", "@"],
      ["static", "@@"],
      ["global", "$"],
      ["plus equals", "+="],
      ["minus equals", "-="],
      ["times equals", "*="],
      ["divide equals", "/="],
      ["plus", "+"],
      ["minus", "-"],
      ["times", "*"],
      ["exponent", "**"],
      ["modulo", "%"],
      ["divided by", "/"],
      ["quotient", "/"],
      ["increment", "++"],
      ["decrement", "--"],
      ["is equal to", "=="],
      ["is very equal to", "==="],
      ["compared to", "<=>"],
      ["matches", "=~"],
      ["does not match", "!~"],
      ["is less than or equal to", "<="],
      ["is greater than or equal to", ">="],
      ["is not equal to", "!="],
      ["is less than", "<"],
      ["is greater than", ">"],
      ["equals", "="],
      ["left shift", "<<"],
      ["right shift", ">>"],
      ["shift left", "<<"],
      ["shift right", ">>"],
      ["inclusive range", ".."],
      ["exclusive range", "..."],
      ["with scope", "::"],
      ["with arguments", "("],
      ["definition", "def"],
      ["pointer", "*"],
      ["address of", "&"],
      ["maps to", "=>"],
      ["binary not", "~"],
      ["binary and", "&"],
      ["binary or", "|"],
      ["binary xor", "^"],
      ["not", "!"],
      ["and", "&&"],
      ["or", "||"],
      ["else if", "elsif"],
      ["finish", "end"],
      ["undefined", "undef"],
      ["of", "("],
      ["out", ")"],
      ["the empty string", "\"\""]
    ]
    
    conversions.each do |conversion|
      add_rule KeywordRule.new(conversion[0], conversion[1])
    end
    
    # Keywords
    keywords = %w{
       alias begin break case class do else ensure false for if
       in module next nil redo rescue retry return self super
       then true  unless until when while yield
    }
    
    keywords.each do |keyword|
      add_rule KeywordRule.new(keyword, keyword)
    end
    
    # Literal Concatenation
    add_rule SharedRules.get(:literal_concatenation)
  end
  
  
  # A list of regular expressions that should be processed as strings
  # with unmodified, whitespace-preserved contents for this language.
  def string_matchers()
    [/"([^\\"]|\\"|\\)*"/]
  end
  
  @@left_grouping_operators = ["(", "[", "{"]
  @@right_grouping_operators = [")", "]", "}"]
  @@concatenating_operators = [".", "::", "..", "..."]
  @@concatenating_on_left_operators = ["++", "--", ",", ";", ":"]
  @@concatenating_on_right_operators = ["@", "@@", "$", ":", "!"]
  
  # Should a space be inserted between the given Tokens?
  def should_space(left, right)
    concatenate_when = [
      @@left_grouping_operators.include?(left.text),
      @@right_grouping_operators.include?(right.text),
      left.flagged?(:literal) && @@left_grouping_operators.include?(right.text),
      @@concatenating_operators.include?(left.text),
      @@concatenating_operators.include?(right.text),
      @@concatenating_on_left_operators.include?(right.text),
      @@concatenating_on_right_operators.include?(left.text)
    ]
    result = !concatenate_when.include?(true)
    return result
  end
  
end