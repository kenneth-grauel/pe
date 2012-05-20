require_relative "Common"

# The general superclass of all of the rules.
# Doesn't really do much.
class Rule
  # All rules have a name so we can print them out for debugging.
  # At this level of generality, that's pretty much all we have.
  def initialize(name)
    @name = name
  end
  
  # Rules are displayed by their names and classes.
  def to_s()
    @name + " (" + self.class.name + ")"
  end
  
  # Apply this rule as many times as possible to the given list of tokens,
  # without modifying the input. Return the number of times this rule was
  # applied, followed by the new list of tokens.
  # If the rule was applied 0 times, it will be safe for the caller to
  # not modify the list of tokens.
  def apply_to_tokens(tokens)
    return 0, tokens
  end
  
  # Return a Set of reserved words which this rule defines.
  # At this point, it's just [].
  def reserved_words()
    Set.new()
  end
end
