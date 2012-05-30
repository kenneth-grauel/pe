require_relative 'ext/my_test'

s = "." * (256)
p s
s.fast_word(0, 0x6365676a)
p s
s.fast_word(3, 0x63656769)
p s
