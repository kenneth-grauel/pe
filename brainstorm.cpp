int n;

for (n = 0; n < 10; n++) {
	glBeginQuery(GL_SAMPLES_PASSSED, ten_queries[n]);
	RenderSimplifiedObject(&object[n]);
	glEndQuery(GL_SAMPLES_PASSED);
}

for (n = 0; n < 10; n++) {
	glGetQueryObjectuiv(ten_queries[n], GL_QUERY_RESULT_AVAILABLE, &the_result);
	
	if (the_result != 0) {
		glGetQueryObjectuiv(ten_queries[n], GL_QUERY_RESULT, &the_result);
	} else {
		the_result = 1;
	}

	if (the_result != 0) {
		RenderRealObject(&object[n]);
	}
}


/*

SMART, libraries and no other context

integer number at 1 finish
for loop number equals 0 and then number is less than 10 and then number plus plus finish
GL begin query with arguments GL samples passed, TEN queries at index number finish
render simplified object with arguments address of object at index number finish
GL end query with arguments GL samples passed finish
close block
for loop number equals 0 and then number is less than 10 and then number plus plus finish
GL get query object UIV with arguments TEN queries at index number out,
GL query result available, address of the result finish
if the result is not equal to 0 finish
GL get query object UIV with arguments TEN queries at index number out,
GL query result, address of the result finish
close block else block
the result equals 1 finish
close block
if the result is not equal to 0 finish
render real object with arguments address of object at index number finish
close block
close block

3'14" = 115 tokens


NAIVE

Integer N at 1;
for loop November at 1 equals 0; November at 1 is less than 10; November  increment ) block
Sahara GL begin query (Byzantine GL samples passed, TEN queries [November at 1]);
Sanskrit render simplified object (address of object [November at 1]);
Sahara GL end query (Byzantine GL samples passed);
}

For loop November at 1 equals 0; November at 1 is less than 10; November increment) block
Sahara GL get query object lower UIV (TEN queries [November at 1],
Sanskrit GL query result available, address of the result);
} else {
the result equals 1;
}

if (the result is not equal to 0) {
Sanskrit render real object (address of object [November at 1]);
}
}

3'12"


*/

int n;

for (n = 0; n < 10; n++) {
	glBeginQuery(GL_SAMPLES_PASSED, ten_queries[n]);
	RenderSimplifiedObject(&object[n]);
	glEndQuery(GL_SAMPLES_PASSED);
}

for (n = 0; n < 10; n++) {
	glGetQueryObjectuiv(ten_queries[n], GL_QUERY_RESULT_AVAILABLE, & the_result);
	
	if (the_result != 0) {
		glGetQueryObjectuiv(ten_queries[n], GL_QUERY_RESULT, &the_result);
	} else {
		the_result = 1;
	}
	
	if (the_result!= 0) {
		RenderRealObject(&object[n]);
	}
}

// 6'20"

