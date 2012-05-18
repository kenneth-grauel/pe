require_relative "Common"
require_relative "Token"
require_relative "Rulebook"
require_relative "ReplacementRule"
require_relative "MiscRules"

module SharedRules
  
  @@rule_bank = {}
  
  private
  def self.register(symbol, rule)
    @@rule_bank[symbol] = rule
    @@current_symbol = symbol
  end
  
  def self.rule()
    @@rule_bank[@@current_symbol]
  end
  
  public
  def self.get(*input)
    if input.count > 1
      input.map { |symbol|
        @@rule_bank[symbol]
      }
    elsif input.count == 1
      @@rule_bank[input[0]]
    else
      nil
    end
  end
  
  
  register :identifier, ReplacementRule.new("identifier / literally")
  rule.requires(/^identifier|literally$/)
  rule.requires(Patterns::ANYTHING)
  rule.has_output lambda { |identifier, content|
    flags = content.flags
    flags.add(:literal)
    flags.add(:not_reserved)
    [Token.new(content.text, flags)]
  }
  
  register :all_upper, ReplacementRule.new("all upper flag with case conversion")
  rule.requires "all"
  rule.requires "upper"
  rule.requires(Patterns::ANYTHING, literal: true)
  rule.has_output lambda { |all, upper, content|
    text = content.text.upcase
    flags = content.flags
    flags.add(:keep_capitals)
    [Token.new(text, flags)]
  }
  
  register :upper, ReplacementRule.new("upper flag with case conversion")
  rule.requires "upper"
  rule.requires(Patterns::ANYTHING, literal: true)
  rule.has_output lambda { |upper, content|
    text = content.text.capitalize
    flags = content.flags
    flags.add(:keep_capitals)
    [Token.new(text, flags)]
  }
  
  register :lower, ReplacementRule.new("lower flag with case conversion")
  rule.requires "lower"
  rule.requires(Patterns::ANYTHING, literal: true)
  rule.has_output lambda { |lower, content|
    text = content.text.downcase
    flags = content.flags
    flags.add(:keep_capitals)
    [Token.new(text, flags)]
  }
  
  register :hex_literal, FlagRule.new("hex literal", :hexadecimal, "0x")
  register :binary_literal, FlagRule.new("binary literal", :binary, "0b")
  register :octal_literal, FlagRule.new("octal literal", :octal, "0")
  register :character_literal, FlagRule.new("character literal", :character, "?")
  register :followed_by, FlagRule.new("followed by", :do_not_concatenate)
  
  register :under_concatenate, ReplacementRule.new("singapore")
  rule.requires "singapore"
  rule.requires(Patterns::ANYTHING, literal: true)
  rule.has_output lambda { |flag, content|
    flags = content.flags
    flags.add(:under_concatenate)
    flags.add(:keep_capitals)
    [Token.new(content.text.downcase, flags)]
  }
  
  register :under_underscores, ReplacementRule.new("hades")
  rule.requires "hades"
  rule.requires(Patterns::ANYTHING, literal: true)
  rule.has_output lambda { |flag, content|
    flags = content.flags
    flags.add(:under_underscores)
    flags.add(:keep_capitals)
    [Token.new(content.text.downcase, flags)]
  }
  
  register :camel_case, ReplacementRule.new("sahara")
  rule.requires "sahara"
  rule.requires(Patterns::ANYTHING, literal: true)
  rule.has_output lambda { |flag, content|
    flags = content.flags
    flags.add(:camel_case)
    flags.add(:keep_capitals)
    [Token.new(content.text.downcase, flags)]
  }
  
  register :class_case, ReplacementRule.new("sanskrit")
  rule.requires "sanskrit"
  rule.requires(Patterns::ANYTHING, literal: true)
  rule.has_output lambda { |flag, content|
    flags = content.flags
    flags.add(:class_case)
    flags.add(:keep_capitals)
    [Token.new(content.text.capitalize, flags)]
  }
  
  register :upper_concatenate, ReplacementRule.new("sydney")
  rule.requires "sydney"
  rule.requires(Patterns::ANYTHING, literal: true)
  rule.has_output lambda { |flag, content|
    flags = content.flags
    flags.add(:upper_concatenate)
    flags.add(:keep_capitals)
    [Token.new(content.text.upcase, flags)]
  }
  
  register :upper_underscores, ReplacementRule.new("byzantine")
  rule.requires "byzantine"
  rule.requires(Patterns::ANYTHING, literal: true)
  rule.has_output lambda { |flag, content|
    flags = content.flags
    flags.add(:upper_underscores)
    flags.add(:keep_capitals)
    [Token.new(content.text.upcase, flags)]
  }
  
  
  register :at_1, AtNumberMisspellingRule.new("at one", "one", "1")
  register :at_2a, AtNumberMisspellingRule.new("at two", "two", "2")
  register :at_2b, AtNumberMisspellingRule.new("at to", "to", "2")
  register :at_3, AtNumberMisspellingRule.new("at three", "three", "3")
  register :at_4a, AtNumberMisspellingRule.new("at four", "four", "4")
  register :at_4b, AtNumberMisspellingRule.new("at for", "for", "4")
  register :at_5, AtNumberMisspellingRule.new("at five", "five", "5")
  register :at_6, AtNumberMisspellingRule.new("at six", "six", "6")
  register :at_7, AtNumberMisspellingRule.new("at seven", "seven", "7")
  register :at_8, AtNumberMisspellingRule.new("at eight", "eight", "8")
  register :at_9, AtNumberMisspellingRule.new("at nine", "nine", "9")
  
  register :at_notation, ReplacementRule.new("at-notation")
  rule.requires(Patterns::ALPHABET, literal: true)
  rule.requires "at"
  rule.requires(Patterns::POSITIVE_INTEGER, numeric: true)
  rule.has_output lambda { |symbol, at, number|
    result = ""
    number.text.each_codepoint do |code|
      index = code - 49   # 1st character = 0th index
      if index >= 0 && index < symbol.text.length
        result << symbol.text[index]
      end
    end
    if result.length > 0
      [Token.new(result, symbol.flags)]
    else
      []
    end
  }
  
  
  register :hex_concatenation, ReplacementRule.new("hexadecimal concatenation")
  rule.requires(Patterns::ANYTHING, hexadecimal: true)
  rule.requires(Patterns::HEXADECIMAL, reserved: false)
  rule.has_output lambda { |accumulator, right|
    flags = accumulator.flags
    [Token.new(accumulator.text + right.text, flags)]
  }

  register :unary_minus_before_numeric, ReplacementRule.new("unary minus before numeric")
  rule.requires "-"
  rule.requires(Patterns::POSITIVE_INTEGER, numeric: true)
  rule.has_output lambda { |minus, value|
    [Token.new(minus.text + value.text, value.flags)]
  }

  register :underscores_within_integers, ReplacementRule.new("underscores within integers")
  rule.requires(Patterns::ANYTHING, numeric: true)
  rule.requires "_"
  rule.requires(Patterns::ANYTHING, numeric: true)
  rule.has_output lambda { |left, under, right|
    [Token.new(left.text + under.text + right.text, left.flags | right.flags)]
  }

  register :with_exponent, ReplacementRule.new("with exponent")
  rule.requires(Patterns::ANYTHING, numeric: true)
  rule.requires "with"
  rule.requires "exponent"
  rule.requires(Patterns::INTEGER, numeric: true)
  rule.has_output lambda { |value, with, exponent, the_exponent|
    [Token.new(value.text + "e" + the_exponent.text, value.flags)]
  }
  
  
  register :literal_concatenation, ReplacementRule.new("literal concatenation")
  rule.requires(Patterns::ANYTHING, literal: true)
  rule.requires(Patterns::ANYTHING, literal: true, do_not_concatenate: false)
  rule.has_output lambda { |left, right|
    # Select a capitalization regime.
    regime_set = left.flags & [
      :under_concatenate, :under_underscores, :camel_case,
      :class_case, :upper_concatenate, :upper_underscores
    ]
    regime = :under_underscores
    if !regime_set.empty?
      regime = regime_set.first
    end
  
    accumulator = left.text
    symbol = right.text
  
    # Ruthlessly execute it.
    if !left.token.flagged?(:keep_capitals)
      if (regime == :under_concatenate || regime == :under_underscores ||
          regime == :camel_case)
        accumulator = accumulator.downcase
      elsif (regime == :class_case)
        accumulator = accumulator.capitalize
      else
        accumulator = accumulator.upcase
      end
    end
  
    use_underscore = false
    if regime == :under_underscores || regime == :upper_underscores
      use_underscore = true
      if (accumulator[-1] == "_" || symbol[0] == "_")
        use_underscore = false
      end
    end
  
    if !right.token.flagged?(:keep_capitals)
      symbol = (case regime
      when :under_concatenate
        symbol.downcase
      when :under_underscores
        symbol.downcase
      when :camel_case
        symbol.capitalize
      when :class_case
        symbol.capitalize
      when :upper_concatenate
        symbol.upcase
      when :upper_underscores
        symbol.upcase
      end)
    end
    
    text = accumulator + (use_underscore ? "_" : "") + symbol
  
    # Result.
    [Token.new(text, left.flags | Set.new([:keep_capitals]))]
  }
end