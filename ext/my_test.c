#include "ruby.h"

static VALUE
rb_str_fast_word(VALUE str, VALUE index, VALUE value)
{
    long pos = NUM2LONG(index);
    int word = NUM2INT(value);

    ((int *)(RSTRING_PTR(str)))[pos] = word;

    return value;
}

static VALUE
rb_str_mark_modify(VALUE str)
{
    rb_str_modify(str);
    return str;
}

void Init_my_test() {
	rb_define_method(rb_cString, "fast_word", rb_str_fast_word, 2);
	rb_define_method(rb_cString, "mark_modify", rb_str_mark_modify, 0);	
}
	