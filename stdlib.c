/*
 * Function declerations
 */
char *num_to_str(int number, int base);
char num_to_char(int num, int base);
int strlen(const char *str);
void reverse(char str[]);

/*
 * maximum number can be (-) signed long
 */
#define MAXLEN 12
char buff[MAXLEN]; // 

/*
 * strlen()
 * calculates length of given string
 */
int strlen(const char *str)
{
	int i;
	for(i=0;str[i] != '\0';i++);
	return i;
}

/*
 * reverse()
 * reverses the string, like 1234567 to 7654321
 */
void reverse(char str[])
{
	int len = strlen(str), i;
	char tmp;
	for(i = 0;i < len/2;i++)
	{
		tmp = str[len-i-1];
		str[len-i-1] = str[i];
		str[i] = tmp;
	}
}

/*
 *  num_to_str()
 *  FIXME Bloody BUG while converting to Octal !
 */
char *num_to_str(int number, int base)
{

	char *ptr = buff;
	int kalan, i, tmp_num = number;

	for(i = 0;i < MAXLEN;i++)
	{
		kalan = tmp_num % base;
		if(tmp_num <= 0){
			*ptr = '\0';
			reverse(buff);
			return buff;
		}
		*ptr++ = num_to_char(kalan, base);
		tmp_num /= base;
	}
	return buff; // should never reach here
}

char num_to_char(int num, int base)
{
	switch(base){

		case 16:
			if(num >= 10 && num <= 15)
				return num + 55;
		case 10:
		case 8:
			if(num >= 0 && num <= 9)
				return num + 48;
		default:
			return '\0';
	}
}

