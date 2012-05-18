require_relative "Common"

class Rulebook
  attr_reader :rules, :name
  
  def initialize(name)
    @rules = []
    @name = name
    @reserved_words = Set.new()
    @reserved_words_need_renewal = false
  end
  
  def add_rule(rule)
    @rules << rule
    @reserved_words_need_renewal = true
  end
  
  def to_s()
    @name + " (Rulebook)"
  end
  
  def reserved_words()
    if @reserved_words_need_renewal
      @reserved_words = Set.new()
      @rules.each do |rule|
        @reserved_words.merge(rule.reserved_words())
      end
      @reserved_words_need_renewal = false
    end
    @reserved_words
  end 
  
  def apply_to_tokens(tokens)
    if Settings::RULEBOOK_VERBOSE
      puts "Apply to tokens: ".green_bold + self.to_s.green
      puts "  Input: " + tokens.inspect.white
    end
    
    total_substitutions = 0
    @rules.each do |rule|
      substitutions, tokens = rule.apply_to_tokens(tokens)
      total_substitutions += substitutions
      if Settings::RULEBOOK_VERBOSE and substitutions > 0
        puts ("  [" + substitutions.to_s + "] ").cyan_bold + rule.to_s.cyan
        puts "      " + tokens.inspect.white
      end
    end
    
    return total_substitutions, tokens
  end
end