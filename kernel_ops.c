#include "limits.h"

int height;
int width;
char video_mem[MAXLEN];
char *video_mem_cur;

void c_clear(void)
{
	int i = 0;
	while(i < (HEIGHT*WIDTH*2))
	{
		video_mem_cur[i] = ' ';
		i++;
		video_mem_cur[i] = 0x07;
		i++;
	}
}
void c_write_out(int size)
{
	int i;
	for(i=0;i < size;i++)
	{
		switch(video_mem[i])
		{
			case '\n':
			case '\t':
			default:
				break;
		}
		if(!(width%WIDTH)){
			width = 0;
			height++;
		}
	}	
}
void c_main(void)
{
	int bytes, height = 0, width = 0;
	video_mem_cur = (char *)0xb8000;
	bytes = c_printf("deneme %d-%d-%d\n",1,2,3);
	bytes = c_printf("is it working? : %s\n","Yes");
	c_clear();
}
