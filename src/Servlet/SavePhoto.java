package Servlet;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLDecoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Collection;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import Function.Connect;

/**
 * Servlet implementation class SavePhoto
 */
@MultipartConfig
@WebServlet("/SavePhoto")
public class SavePhoto extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SavePhoto() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @param <Part>
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected  void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
		Collection<Part>L = request.getParts();
		System.out.println(L);
		for(Part part:L) {
			int count = 0;
			InputStream is =  part.getInputStream(); //获取文件的输入流,该步骤非常的重要
			String fileName = part.getSubmittedFileName(); //获取文件名
			System.out.println(fileName);
			try {
				Connection coon = new Connect().buildConnection(); //建议与数据库之间的连接
				ResultSet rs = null;
				Statement st = coon.createStatement();
				rs = st.executeQuery("select id from myphoto");
				while(rs.next()) {
					count = rs.getInt("id");
				}
				count++;
				System.out.println(count);
				String query = "insert into myphoto(id,photo_name,photo) values(?,?,?)";
				PreparedStatement ps = coon.prepareStatement(query);
				ps.setInt(1,count);
				
				ps.setString(2, fileName);
				
				ps.setBlob(3,is);
				
				ps.executeUpdate();
				coon.close();
			}
			catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
		}
	}

}
