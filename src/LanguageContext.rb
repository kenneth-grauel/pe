require_relative "Common"
require_relative "Rulebook"

class LanguageContext
  attr_reader :name, :rulebook
  
  def initialize(name = "Empty")
    @name = name
    @rulebook = Rulebook.new(name)
  end
  
  def to_s
    @name + ", " + @rulebook.rules.count.to_s + " rules (LanguageContext)"
  end
  
  def add_rule(rule)
    @rulebook.add_rule rule
  end
  
  def add_rules(rules)
    rules.each do |rule|
      add_rule rule
    end
  end
end



