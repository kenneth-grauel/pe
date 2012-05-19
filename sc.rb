
require "ripper"

files = `ls src/*.rb `
files = files.split("\n")

token_total = 0
line_total = 0
byte_total = 0

puts ""
puts "  File                           | Lines | Tokens |   Chars | "
puts "---------------------------------+-------+--------+---------+-"
files.each do |filename|
  File.open(filename, "rb") do |file|
    contents = file.read
    tokens = Ripper.lex(contents)
    t = tokens.count { |item|
      item[2] !~ /^\s*$/
    }
    l = contents.split("\n").count
    b = contents.length
    token_total += t
    line_total += l
    byte_total += b
    puts "  %-30s | %5d | %6d | %7d |" % [filename, l.to_s, t.to_s, b.to_s]
  end
end
puts "---------------------------------+-------+--------+---------+-"
puts "  TOTAL                          | " + ("%5d | %6d | %7d |" % [line_total, token_total, byte_total])
puts

