package myQQMusic;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStreamReader;

public class IO 
{
	public static String myname=null;
	public static BufferedReader br=null;
	public static BufferedReader doit(String name) throws FileNotFoundException
	{
		if(myname==null||name==null||br==null||!myname.equals(name))
		{
			myname=name;
			return new BufferedReader(new InputStreamReader(new FileInputStream("C:\\workspace\\WebMusicPlayer\\music\\"+name)));
		}
		else return br;
	}
}
