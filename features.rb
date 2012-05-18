# Comment

=begin
this is embedded documentation.
everything here should be ignored.
=end

123
-123
1_234
123.45
1.2e-3
0xffff
0b01011
0377
?a
?\C-a
?\M-a
?\M-\C-a

:symbol

$global_variable = 5

class ClassName
  CONSTANT = 3.14
  attr_accessor :symbol_lower, :instance_variable
  
  def initialize
    @@static = "word"
    @instance_variable = 123
  end
  
  def method_name(argument_name)
    return 2 * argument_name + self.instance_variable
  end
end

puts ClassName::CONSTANT
example = ClassName.new
puts example.instance_variable
puts example.method_name(50)
nil
true
false
puts __FILE__
puts __LINE__



""
"this is a string expression\n"
"concat#{4 + 5}"
'concat#{4 + 5}'
%q!I said, "You said, 'She said it.'"!
%!I said, "You said, 'She said it.'"!
%Q('This is it.'\n)

"\t\n\r\f\b\a\e\s\122\x45\\\*"

puts `wc *.rb`
puts %x{ wc *.rb }

/^Ruby the OOPL/
/Ruby/i
/my name is #{4 + 5}/o
%r|^/usr/local/.*|

/^$.\w\W\s\S\d\D\A\Z\z\b\B[^0-9]*.+A{3,4}A?(A|B)/


print <<EOF
The price is #{$Price}.
EOF

print <<"EOF";
The price is #{$Price}.
EOF

print <<`EOC`
echo hi there
echo lo there
EOC

puts(<<"THIS", 23, <<'THAT')
Here's a line
or two.
THIS
and here's another.
THAT

  eval <<-EOS			# delimiters can be indented
    def foo
      print "foo\n"
    end
  EOS

[]
many = [1, 2, 3]
%w( words that we make )
%w{ more words }

{}
{ :k1 => :v1, :k2 => :v2 }
{ symbol: 1, second: 2 }

def multiple(head, *tail)
  print head + ": "
  tail.each do |x|
    print x + " "
  end
end


  
  
  
  
  
  
  
  
  
  
  

