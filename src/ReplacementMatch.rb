require_relative "Common"

class ReplacementMatch
  def initialize(token, subparts = [])
    @token = token
    @subparts = subparts
  end
  
  attr_reader :token, :subparts
  
  def text()
    @token.text
  end
  
  def flags()
    @token.flags
  end
  
  def part(index)
    @subparts[index - 1]
  end
  
  def to_s()
    result = @token.to_s()
    if subparts != nil
      result << "{" + @subparts.join(", ") + "}"
    end
    result
  end
  
end