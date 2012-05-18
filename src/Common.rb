if $__common_once == nil
  require 'smart_colored/extend'
  require 'levenshtein'
  require 'set'
  require "singleton"

  module Settings
    RULEBOOK_VERBOSE = true
    TESTSUITE_STOP_AT_ERROR = true
  end

  module Patterns
    ANYTHING = /^.*$/
    POSITIVE_INTEGER = /^[0-9]+$/
    INTEGER = /^(|-)[0-9]+$/
    HEXADECIMAL = /^[0-9a-fA-F]+$/
    ALPHABET = /^[a-zA-Z]+$/
  end
  
  $__common_once = true
end