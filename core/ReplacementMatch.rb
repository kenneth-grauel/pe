require_relative "Common"

# ReplacementRules operate by lining up a pattern consisting of one or more
# Strings or Regexps to a list of Tokens. The result of this operation is
# an array of ReplacementMatches.
# 
# Each ReplacementMatch instance is therefore the result of matching a single
# String or Regexp to a single Token.
#
# If a ReplacementMatch is the result of matching a String pattern, then
# it will have a token but no subparts. Otherwise it will have both.
class ReplacementMatch
  
  # Default constructor. Token required, subparts optional.
  def initialize(token, subparts = [])
    @token = token
    @subparts = subparts
  end
  
  # The token that was matched in the original input.
  attr_reader :token
  
  # Any ()-delimited matches in the Regexp, if one matched this token.
  # Note that the zero-th subpart is not the entire token's text, but the
  # first ()-delimited match.
  #
  # For example, in the regular expression /(\n)(x)/, subparts[1] refers to
  # (x).
  attr_reader :subparts
  
  # The verbatim text of the token that was matched.
  def text()
    @token.text
  end
  
  # The flags Set of the token that was matched.
  def flags()
    @token.flags
  end
  
  # The index-th subpart of a Regexp match.
  #
  # Note that the indexing here is the SAME as in a normal regexp. For example,
  # in the regular expression /(\n)(x)/, part(2) refers to (x).
  def part(index)
    @subparts[index - 1]
  end
  
  # Turn this ReplacementMatch into a string of format "token{subparts}"
  def to_s()
    result = @token.to_s()
    if subparts != nil
      result << "{" + @subparts.join(", ") + "}"
    end
    result
  end
  
end