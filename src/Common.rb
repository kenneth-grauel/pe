# This is required at the top of every other Ruby file.
# All external libraries are linked to here to simplify matters.

# Ensure this code is loaded only once.
# Theoretically Ruby 1.9 should do this for me, but I was getting a few
# warnings from the set library about redefined constants.
if $__common_once == nil
  require 'smart_colored/extend'
  require 'levenshtein'
  require 'set'
  require "singleton"

  # Global settings constants.
  module Settings
    RULEBOOK_VERBOSE = true
    TESTSUITE_STOP_AT_ERROR = true
  end

  # Various regular expressions of interest.
  module Patterns
    ANYTHING = /^.*$/
    POSITIVE_INTEGER = /^[0-9]+$/
    INTEGER = /^(|-)[0-9]+$/
    HEXADECIMAL = /^[0-9a-fA-F]+$/
    ALPHABET = /^[a-zA-Z]+$/
  end
  
  $__common_once = true
end