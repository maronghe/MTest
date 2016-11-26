package myQQMusic;
import java.io.BufferedReader;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@SuppressWarnings("serial")
@WebServlet(urlPatterns="/getString")
public class GetMusicLrc extends HttpServlet
{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException 
	{
		String name=req.getParameter("name");
		double time=Double.parseDouble(req.getParameter("time"));
		resp.setCharacterEncoding("utf-8");
		req.setCharacterEncoding("utf-8");
		BufferedReader br=IO.doit(name.substring(0, name.length()-4)+".lrc");
		String ss=br.readLine();
		double down=0;
		double up=0;
		String show="";
		while((ss=br.readLine())!=null)
		{
			if(ss.length()>=10&&ss.substring(0,10).matches("\\[\\d{2}:\\d{2}.\\d{2}\\]"))
			{
				up=Integer.parseInt(ss.substring(1,3))*60*1000+Integer.parseInt(ss.substring(4,6))*1000+Integer.parseInt(ss.substring(7,9))*10;                
				if(time>down&&time<up)
				{
					if(show.length()>=11)
					resp.getWriter().write(show.substring(10,show.length()));else
					resp.getWriter().write(ss.substring(10,ss.length()));
					return;
				}
				show=ss;
				down=up;
			}
		}
		resp.getWriter().write(show.substring(10,show.length()));
		
	}
}
