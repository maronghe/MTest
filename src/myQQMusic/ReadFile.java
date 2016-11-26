package myQQMusic;
import java.io.IOException;
import java.util.Collection;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
@SuppressWarnings("serial")
@MultipartConfig()
@WebServlet(urlPatterns="/readfile")
public class ReadFile extends HttpServlet 
{	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException 
	{
		resp.setContentType("text/html;charset=UTF-8");
		req.setCharacterEncoding("utf-8");
		resp.setCharacterEncoding("utf-8");  
		Collection<Part> parts=req.getParts();
		@SuppressWarnings("unused")
		int index=-1;
		for(Part p:parts)
		{
			String header = p.getHeader("content-disposition");
			String fileName = getFileName(header);
			p.write(req.getSession().getServletContext().getRealPath("/")+"/music/"+fileName);
		}
	}

	private String getFileName(String header) 
	{
		String[] tempArr1 = header.split(";");
		String[] tempArr2 = tempArr1[2].split("=");
		String fileName = tempArr2[1].substring(tempArr2[1].lastIndexOf("\\")+1).replaceAll("\"", "");
		return fileName;
	}

}
