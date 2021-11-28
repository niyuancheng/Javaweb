package Servlet;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Function.getResult;

/**
 * Servlet implementation class Photo
 */
@WebServlet("/Photo")
public class Photo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Photo() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String id = request.getParameter("id");
		String query = "select * from myphoto where id="+id;
		try {
			ResultSet rs = getResult.Select(query);
			if(rs.next()) {
				Blob image = rs.getBlob("photo");
				InputStream in = image.getBinaryStream(); //获取图像的输入流
				ServletOutputStream soutStream = response.getOutputStream(); //获取图片向前端页面的输出流
				if(in.equals(null)) {
					
					soutStream.println("照片无法显示<br/>");
				}
				else {
					 byte[] buffer = new byte[1024]; //定义字节流缓冲数组
			            // 循环输出字节流, 为空时，read()返回 -1
			            while (in.read(buffer) != -1) {
			                soutStream.write(buffer);
			            }
			            // 输入完毕，清楚缓冲
			            soutStream.flush();
			            soutStream.close();
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
