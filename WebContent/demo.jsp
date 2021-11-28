<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*, java.util.*, java.io.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="./javascript/clickheart.js"></script>
<style>
	#head td {
		width:100px;
		text-align:center;
		font-size:20px;
	}
	ul {
	  	list-style-type: none;
	  	margin: 0;
	  	padding: 0;
	  	overflow: hidden;
	  	background-color: #333;
	}
	
	li {
	  float: left;
	  border-right:1px solid #bbb;
	}
	
	li:last-child {
	  float:right;
	  border-right: none;
	}
	
	li a {
	  display: block;
	  color: white;
	  text-align: center;
	  padding: 14px 16px;
	  text-decoration: none;
	}
	
	li a:hover:not(.active) {
	  background-color: #111;
	}
	
	.active {
	  background-color: #4CAF50;
	}
	
</style>
<title></title>
</head>
<body>
<div class='navigation'>
		<ul>
			<li><a href="test_index.html" class="active">诺亚词典</a></li>
			<li><a href="translation.html">诺亚翻译</a></li>
			<li><a href='friend.jsp'>朋友圈</a></li>
			<li><a href='#'>关于我们</a></li>
		</ul>
</div>
<div>
	<h1 style="text-align:center">如下为你的单词查询结果</h1>
</div>
<br/>
<%! ResultSet rs = null;%>
<%
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/word?serverTimezone=UTC ","root","nyc757791");
	String search_content = request.getParameter("word");
	Statement statement = conn.createStatement();
	//out.println(search_content);
	String sql = "select * from myword where english like '% " + search_content + " %' ";
	//out.println(sql);
	rs = statement.executeQuery(sql);		
%>
<table align="center" border="2px" >
	<tr id="head">
		<td>序号</td>
		<td>英文会意</td>
		<td>英标</td>
		<td>中文会意</td>
	</tr>
	<% while(rs.next()) { %>
		<tr>
			<td><%=rs.getInt("id") %></td>
			<td><%=rs.getString("english") %></td>
			<td><%=rs.getString("vocabulary") %></td>
			<td><%=rs.getString("chinese") %></td>
		</tr>
	<% } %>
</table>
</body>
</html>