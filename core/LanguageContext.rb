require_relative "Common"
require_relative "Rulebook"

# Encapsulates all language-specific code and features.
# You probably shouldn't instantiate this class; take a look at RubyContext
# for a particular example of this class in action.
class LanguageContext
  attr_reader :name, :rulebook
  
  # At initialize time, language contexts do not by default contain any rules.
  def initialize(name = "Empty")
    @name = name
    @rulebook = Rulebook.new(name)
  end
  
  def to_s
    @name + ", " + @rulebook.rules.count.to_s + " rules (LanguageContext)"
  end
  
  # Add a single Rule to this LanguageContext's rulebook.
  def add_rule(rule)
    @rulebook.add_rule rule
  end
  
  # Add multiple Rules to this LanguageContext's rulebook.
  def add_rules(rules)
    rules.each do |rule|
      add_rule rule
    end
  end
  
  # A list of regular expressions that should be processed as strings
  # with unmodified, whitespace-preserved contents for this language
  def string_matchers()
    []
  end
  
  # Should a space be inserted between the given Tokens?
  def should_space(left, right)
    true
  end
end



