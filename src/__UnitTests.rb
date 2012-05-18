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
0x8abff
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