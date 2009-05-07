#include <stdarg.h>
#include "stdlib.h"
#include "limits.h"

extern char video_mem[];
int c_printf(const char *fmt, ...);
int c_vsnprintf(char *fbmem, int maxlen, const char *fmt, va_list ap);
int c_vsprintf(char *fbmem, const char *fmt, va_list ap);
static void insert_string(char *fbmem, int maxlen, const char *str, void *data, int pos, int *fbmem_cur, char type);

int c_printf(const char *fmt, ...)
{
	va_list ap;
	va_start(ap, fmt);
	int written = c_vsnprintf(video_mem, MAXLEN, fmt, ap);
	va_end(ap);
	return written;
}

int c_vsprintf(char *fbmem, const char *fmt, va_list ap)
{
	return c_vsnprintf(fbmem, MAXLEN, fmt, ap);
}

int c_vsnprintf(char *fbmem, int maxlen, const char *fmt, va_list ap)
{
	int fmtlen = strlen(fmt);
	if(fmtlen > maxlen){
		fmtlen = maxlen;
	}
	char *fmt_strt = (char *) fmt;
	int pos, saved_pos = 0, fbmem_cur = 0;

	for(;*fmt; fmt++)
	{
		if(*fmt != '%'){
			continue;
		}
		char type = *(fmt+1);
		pos = fmt - fmt_strt;

		/*
		 * This if statement ensures copying of the characters between 
		 * '%' sign
		 */
		if(saved_pos) {
			for(;saved_pos < pos;fbmem[fbmem_cur] = fmt_strt[saved_pos], saved_pos++, fbmem_cur++);
			saved_pos += 2;
		}else{
			saved_pos = pos + 2;
		}
		switch(type)
		{
			case 'd':
				{
					int number = va_arg(ap, int);
					insert_string(fbmem, maxlen, fmt_strt, (void *)&number, pos, &fbmem_cur, type);
				}
				break;
			case 'c':
				{
					char chr = va_arg(ap, int);
					insert_string(fbmem, maxlen, fmt_strt, (void *)&chr, pos, &fbmem_cur, type);
				}
				break;
			case 's':
				{
					char *stret = va_arg(ap, char *);
					insert_string(fbmem, maxlen, fmt_strt, (void *)stret, pos, &fbmem_cur, type);
				}
				break;
			default:
				break;
		}
	}
	
	/*
	 * Append characters from last sign
	 */
	if(fmtlen != saved_pos){
		for(;saved_pos < fmtlen;fbmem[fbmem_cur] = fmt_strt[saved_pos], saved_pos++, fbmem_cur++);
	}
	fbmem[fbmem_cur++] = '\0';
	return fbmem_cur;
}
static void insert_string(char *fbmem, int maxlen, const char *str, void *data, int pos, int *fbmem_cur, char type)
{
	if(*fbmem_cur == 0) {
		for(;(*fbmem_cur) < pos;(fbmem[*fbmem_cur] = str[*fbmem_cur]), (*fbmem_cur)++);
	}
	
	switch(type)
	{
		case 'd':
			{
				char *data_str = (char *)num_to_str(*((int *)data), 10);
				int data_str_len = strlen(data_str), i;
				for(i = 0;*fbmem_cur < maxlen && i < data_str_len;fbmem[*fbmem_cur] = data_str[i],(*fbmem_cur)++,i++);
			}
			break;
		case 'c':
			{
				char chr = *((char *)data);
				fbmem[*fbmem_cur] = chr;
				(*fbmem_cur)++;
			}
			break;
		case 's':
			{
				char *data_str = (char *)data;
				int data_str_len = strlen(data_str),i;
				for(i = 0;*fbmem_cur < maxlen && i < data_str_len;fbmem[*fbmem_cur] = data_str[i],(*fbmem_cur)++,i++);
			}
			break;
		default:
			break;
	}
}
