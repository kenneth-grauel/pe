# Integer literals
#: 123
123
# Negative integer literals
#: -123
-123
# Underscores embedded in integers
#: 1_234
1_234
# Floating-point literals
#: -123.45
-123.45
# Scientific notation
#: 1.24 with exponent -3
1.24e-3
# Hexadecimal notation
#: hex literal 8abFF
0x8ABFF
# Binary notation
#: binary literal 01011
0b01011
# Octal notation (preserve leading zeros)
#: 0753
0753
# Octal notation (“octal literal”)
#: octal literal 753
0753
# Character literals (? form, lower to lower)
#: character literal a
?a
# Character literals (? form, upper to lower)
#: character literal A
?a
# Character literals (? form, explicit upper)
#: character literal upper a
?A
# Identifiers (no context, underscores, one word)
#: greasy
greasy
# Identifiers (no context, underscores, two words)
#: slippery eel
slippery_eel
# Identifiers (no context, underscores, many words)
#: best dancer from Utah
best_dancer_from_utah
# Identifiers (no context, underscores, case removal)
#: BeST Dancer FROM UTAH
best_dancer_from_utah
# Identifiers (no context, underscores, multiple identifiers)
#: fake function followed by another function
fake_function another_function
# Identifiers (no context, underscores, with explicit underscore)
#: _my identifier
_my_identifier
# Identifiers (no context, underscores, with two explicit underscores)
#: __traits__
__traits__
# Identifiers with numbers (after text)
#: point identifier 1
point_1
# Identifiers with numbers (in between text)
#: distance identifier 12 rectified
distance_12_rectified
# Identifiers with numbers (before text)
#: 12 distance rectified
12 distance_rectified
# Prefixing (single characters)
#: hello at 1 hello at 2 hello at 3
h_e_l
# Prefixing (multiple characters)
#: hello at 123 there are at 12 many at 24 possibilities at 34
hel_there_ar_ay_ss
# Prefixing (out of bounds)
#: test at 012 test at 456 test at 7 test at 7 test at 7 final at 0135
te_t_fnl
# Prefixing (multiple identifiers)
#: process vertex at 1234 followed by exit at 2 position at 123
process_vert x_pos
# Prefixing (English number words for single characters)
#: test at one test at two test at to test at three test at four test at for
t_e_e_s_t_t
# Prefixing (including numbers in identifiers)
#: variable at 123 identifier 1
var_1
# Case (no context, glommed together)
#: Singapore process name
processname
# Case (no context, underscores)
#: Hades default processor
default_processor
# Case (no context, camel)
#: Sahara the example
theExample
# Case (no context, upper 1st letters)
#: Sanskrit yes the example
YesTheExample
# Case (no context, all upper, no underscores)
#: Sydney kill them all
KILLTHEMALL
# Case (no context, all upper)
#: Byzantine screaming monkeys
SCREAMING_MONKEYS
# Combined identifiers (1)
#: Sanskrit Next at 1 step at one string
NSString
# Combined identifiers (2)
#: Singapore __golf at 1 shared
__gshared
# Combined identifiers (3)
#: Sanskrit  next at 1 step at one managed object model
NSManagedObjectModel
# Combined identifiers (4)
#: Sanskrit X at 1 Michael at 1 quaternion is natural at 12 number at 1
XMQuaternionIsNaN
# Combined identifiers (5)
#: Sydney exit at 2 Michael at 1 identifier global constant at 12345
XMGLOBALCONST
# Identifier types (member variables)
#: member X position at 123
@x_pos
# Identifier types (class variables)
#: static string reader
@@string_reader
# Identifier types (globals)
#: global parser ID
$parser_id
# Literal hinting (1)
#: identifier static string reader
static_string_reader
# Literal hinting (2)
#: Sanskrit inside identifier at identifier 23
InsideAt23
# Literal hinting (3)
#: identifier Byzantine identifier 3
byzantine_3
# Splitting identifiers at function words
#: member description at 1234 member unique ID
@desc @unique_id
# Upper keyword in identifiers
#: Something upper identifier else
something_Else
# Lower keyword in identifiers
#: Sanskrit something lower identifier else
Somethingelse
# All upper keyword in identifiers
#: Singapore front all upper VC  source
frontVCsource
# Expressions (1)
#: Count plus equals X divided by 2
count += x / 2
# Expressions (2)
#: remaining tasks minus equals Sanskrit tasks. Complete count of nil out
remaining_tasks -= Tasks.complete_count(nil)
# Expressions (3)
#: Draw factor times equals  upper settings with scope Byzantine draw factor multiplier
draw_factor *= Settings::DRAW_FACTOR_MULTIPLIER
# Expressions (4)
#: member matrix at 123 divide equals member matrix at 123. Determine at 123 of out
@mat /= @mat.det()
# Expressions (5)
#: upper math.squirt at 1256 of vertex.X exponent 2+ vertex.Y exponent 2 out
Math.sqrt(vertex.x ** 2 + vertex.y ** 2)
# Expressions (6)
#: Contrast ratio minus ( static correction factor times member all upper correction)
contrast_ratio - (@@correction_factor * @CORRECTION)
# Expressions (7)
#: cycle equals (cycle +1)modulo100
cycle = (cycle + 1) % 100
# Expressions (8)
#: confusing equals something increment plus something literally else decrement
confusing = something++ + something_else--
# Expressions (9)
#: self is equal to other
self == other
# Expressions (10)
#: input context is very equal to upper string
input_context === String
# Expressions (11)
#: (member text compared to other.text) is equal to 0
(@text <=> other.text) == 0
# Expressions (12)
#: thing matches  Singapore regular at 123 expression at 123 and thing does not match Singapore other_regular at 123  Expression at 123
thing =~ regexp && thing !~ other_regexp
# Expressions (13)
#: member location. Distance of actor out is less than near or member location. Distance of actor out is greater than far
@location.distance(actor) < near || @location.distance(actor) > far
# Expressions (14)
#: Sanskrit token. Text is not equal to the empty string
Token.text != ""
# Expressions (15)
#: bound is greater than or equal to 0 and bound is less than or equal to 100
bound >= 0 && bound <= 100
# Expressions (16)
#: (red shift left 16) plus (Green left shift 8) plus blue
(red << 16) + (green << 8) + blue
# Expressions (17)
#: [(red shift right 16) binary and hex literal FF, (green shift right 8) binary and hex literal FF, blue binary and hex literal FF]
[(red >> 16) & 0xFF, (green >> 8) & 0xFF, blue & 0xFF]
# Expressions (18)
#: (1 inclusive range 100).includes? Of 50 out and (1 exclusive range 100).includes? Of 50 out
(1..100).includes?(50) && (1...100).includes?(50)
# Expressions (19)
#: definition add rule with arguments rule, pointer the rest, address of block out
def add_rule(rule, *the_rest, &block)
# Expressions (20)
#: {symbol literally identifier maps to 3}
{ :identifier => 3 }
# Expressions (21)
#: binary not hex literal FF binary and  hex literal FF  binary or 0 binary XOR 0 is equal to 0
~0xFF & 0xFF | 0 ^ 0 == 0
# Expressions (22)
#: else if condition or that condition or not the other condition
elsif condition || that_condition || !the_other_condition
# Expressions (23)
#: Return true if member flags. Include? Of symbol unary out
return true if @flags.include?(:unary)
# Expressions (24)
#: Result shift left if member player.X position at 123 is less than 0 then the empty string else suffix finish
result << if @player.x_pos < 0 then "" else suffix end
# Expressions (25)
#: requires followed by incorrect word, literal symbol is true, reserved symbol is false
requires incorrect_word, literal: true, reserved: false
# Expressions (26)
#:  token.set flag symbol numeric
token.set_flag :numeric
# Strings (1)
#: register symbol identifier binary literal, Sanskrit flag rule.new of "binary literal", symbol binary, "0b" out
register :binary_literal, FlagRule.new("binary literal", :binary, "0b")