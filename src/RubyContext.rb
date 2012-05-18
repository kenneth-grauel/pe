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
      ["divided by equals", "/="],
      ["plus", "+"],
      ["minus", "-"],
      ["times", "*"],
      ["exponent", "**"],
      ["modulo", "%"],
      ["divided by", "/"],
      ["quotient", "/"],
      ["increment", "++"],
      ["decrement", "--"],
      ["equals", "="],
      ["is equal to", "=="],
      ["is very equal to", "==="],
      ["compared to", "<=>"],
      ["matches", "=~"],
      ["does not match", "!~"],
      ["is not equal to", "!="],
      ["is less than", "<"],
      ["is greater than", ">"],
      ["is less than or equal to", "<="],
      ["is greater than or equal to", ">="],
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
      ["undefined", "undef"]
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
  
  
end