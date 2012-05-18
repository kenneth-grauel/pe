require_relative "Common"
require_relative "Token"
require_relative "LanguageContext"

# This is sort of a catch-all module for static methods dealing with
# speech processing. They're more or less stateless.
module SpeechProcessor
  
  # Categorizes characters into character classes.
  # Browse the source below to see what exciting symbols are possible.
  def self.character_class(char)
    code = char.ord
    if code <= 32
      return :whitespace
    elsif code >= 48 and code <= 57
      return :numeric
    elsif (code >= 65 and code <= 90) or (code >= 97 and code <= 122)
      return :letter
    elsif char == '(' or char == ')'
      return :parentheses
    elsif char == '[' or char == ']'
      return :brackets
    elsif char == '{' or char == '}'
      return :braces
    elsif code <= 127
      return :punctuation
    else
      return :other
    end  
  end
  
  # Breaks the input text into an array of substrings where the character
  # class changes. If include_whitespace is false, the resulting array will
  # contain no tokens from character class :whitespace.
  # Return type: [String]
  def self.tokenize(text, include_whitespace)
    
    # Check for special patterns
    
    # Double-quoted string
    match = /"([^\\"]|\\"|\\)*"/.match(text)
    if match != nil
      front, back = match.offset(0)
      front_tokens = tokenize(text[0, front], include_whitespace)
      back_tokens = tokenize(text[back, text.length - back], include_whitespace)
      
      return front_tokens + [match[0]] + back_tokens
    end
    
    # Treat as a normal sequence of tokens
    tokens = []
    previous_class = :nothing
    text.each_char do |char|
      current_class = character_class(char)
      if previous_class != current_class
        if !include_whitespace && previous_class == :whitespace
          tokens.last.clear()
        else
          tokens << ""
        end
      end
      previous_class = current_class
      tokens.last << char
    end
    if !include_whitespace && previous_class == :whitespace
      tokens.delete_at(tokens.count - 1)
    end
    tokens
  end
  
  # Breaks the input text into an array of tokens where the character
  # class changes. Attempts to make a 1st pass at setting the flags
  # correctly. Removes whitespace by default.
  # Return type: [Token]
  def self.tokenize_and_flag(text, reserved_words = Set.new())
    tokens = []
    tokenize(text, false).each do |literal_text|
      
      token = Token.new(literal_text)
      if literal_text =~ /^[0-9.]+$/
        token.set_flag :numeric
      end
      if reserved_words.include?(literal_text)
        #token.set_flag :reserved
      end
      if literal_text =~ /^".*"$/
        token.set_flag :reserved
      end
      if literal_text =~ /^[A-Za-z_][A-Za-z0-9_]*$/
        token.set_flag :literal
      end
      tokens << token
    end
    tokens
  end
  
  def self.tokens_to_string(tokens)
    if tokens.count <= 0
      return ""
    end
    
    previous = tokens[0]
    result = previous.text
    if !previous.flagged?(:keep_capitals)
      # Note: The downcase! that was originally here caused a bug
      # where some reference to an object propagated from here to there
      # and ended up screwing up something in the rules
      # Be very careful of destructive object modifications...
      result = result.downcase
    end
    
    for index in 1...tokens.count
      current = tokens[index]
      should_space = true
      
      if current.text =~ /^[\)\]\}]$/
        should_space = false
      elsif previous.text =~ /^[\(\[\{]$/
        should_space = false
      elsif previous.flagged?(:literal) && current.text =~ /^[\(\[\{]$/
        should_space = false
      elsif previous.text == "." || current.text == "."
        should_space = false
      elsif previous.text =~ /^(\@|\@\@|\$|\:)$/ && current.flagged?(:literal)
        should_space = false
      elsif current.text =~ /^[\,\;\:]$/
        should_space = false
      elsif previous.text == "!"
        should_space = false
      end
      # TODO:  Handle unary minus
      
      if should_space
        result << " "
      end
      
      if !current.flagged?(:keep_capitals)
        result << current.text.downcase
      else
        result << current.text
      end
      
      previous = current
    end
    
    result
  end
  
  # The main entry point to speech processing. A string of speech goes in,
  # and a string of code comes out. This particular version attempts to
  # process the input string without any particular context.
  # I'm fairly certain this is going to have to change as the program
  # develops and matures.
  def self.convert_to_code(speech, language_context)
    tokens = tokenize_and_flag(speech, language_context.rulebook.reserved_words())
    rulebooks_to_apply = [
      language_context.rulebook
    ]
    total_substitutions = 0
    rulebooks_to_apply.each do |rulebook|
      substitutions, tokens = rulebook.apply_to_tokens(tokens)
      total_substitutions += substitutions
    end
    return tokens_to_string(tokens)
  end
end
