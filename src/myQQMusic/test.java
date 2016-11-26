package myQQMusic;

public class test 
{
	public static void main(String[] args) 
	{
		int full=0;
		int day=0;
		while(full<1000)
		{
			day++;
			full+=25;
			if(day!=0&&day%5==0)
			{
				full-=60;
			}
		}
		System.out.println(day);
	}
}
