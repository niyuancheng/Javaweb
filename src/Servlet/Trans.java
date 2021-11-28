package Servlet;

import java.util.*; 
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import Function.Translate;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

/**
 * Servlet implementation class Trans
 */
@WebServlet("/Trans")
public class Trans extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Trans() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String APP_ID = "20210725000897424";
		String SECURITY_KEY = "cjKHYoBaXBirH02_cWjp";
		
		System.out.println("后台已经接受到数据");
		
		response.setCharacterEncoding("UTF-8");  
		response.setContentType("text/html");  
		
		String content = request.getParameter("content");
		String choice = request.getParameter("choice");
		if(!choice.equals("a")) {
			content = URLDecoder.decode(content, "UTF-8");
		}
		System.out.println(content);
		System.out.println(choice);
		Translate api = new Translate(APP_ID, SECURITY_KEY);
		if(choice.equals("a")) {
			System.out.println("执行a");
			content = api.getTransResult(content, "auto", "zh");
		}
		else if(choice.equals("b")) {
			System.out.println("执行b");
			content = api.getTransResult(content, "auto", "en");
		}
		else if(choice.equals("c")) {
			System.out.println("执行c");
			content = api.getTransResult(content, "auto", "jp");
		}
		else if(choice.equals("d")) {
			System.out.println("执行d");
			content = api.getTransResult(content, "auto", "kor");
		}
		System.out.println(content);
		
		Map<String,String> map = new HashMap<String,String>();
		map.put("content", content);
		JSONObject json = new JSONObject(map);
		PrintWriter writer = response.getWriter();
		String data = json.toString();
		System.out.println(data);
		writer.write(content); //将翻译好的内容也就是content传送到前端
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
