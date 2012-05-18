require_relative "Common"

# Represents a single token from speech input.
# A token consists of text and 0 or more flags.
class Token
  attr_reader :text, :flags
  
  # Initialize with both text and flags
  def initialize(text, *flags)
    @text = text
    if flags.count == 1 && flags[0].is_a?(Set)
      @flags = flags[0]
    else
      @flags = Set.new(flags)
    end
  end
  
  # Append the flags from the given token.
  def add_flags_from(token)
    token.flags.each do |f|
      set_flag f
    end
  end
  
  # Set given flag to true
  def set_flag(symbol)
    @flags.add(symbol)
  end
  
  # Set given flag to false
  def clear_flag(symbol)
    @flags.delete(symbol)
  end
  
  # Is the given flag set?
  def flagged?(symbol)
    @flags.member?(symbol)
  end
  
  # Keep track of short characters for on-screen display of flags.
  FLAG_CHARACTER = {
    numeric: "n",
    literal: "l",
    hexadecimal: "X",
    keep_capitals: "C",
    reserved: "r",
    not_reserved: "^",
    binary: "B",
    octal: "O",
    character: "c",
    
    do_not_concatenate: "0",
    under_concatenate: "1",
    under_underscores: "2",
    camel_case: "3",
    class_case: "4",
    upper_concatenate: "5",
    upper_underscores: "6"
  }
  
  # Give short textual representation of this token.
  # Flags are separated by a period from the rest of the text.
  def to_s()
    result = "@#{@text}"
    if !@flags.empty?
      result << "."
    end
    @flags.each do |f|
      char = Token::FLAG_CHARACTER[f]
      if char == nil
        result << "?"
      else
        result << char
      end
    end
    result
  end
end
