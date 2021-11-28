<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.*,java.io.*,Function.Connect,Function.getResult" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>你的朋友圈</title>
<script src="./Jquery/jquery-3.5.1.js"></script>
<script src="./javascript/MxSlider.js"></script>
<script src="./javascript/clickheart.js"></script>
<link href="css/menu.css" rel="stylesheet" />
<link href="css/MxSlider.css" rel="stylesheet" />
<style>
	* {
	  padding: 0;
	  margin: 0;
	  box-sizing: border-box;
	}
	:root {
	  --menu-speed: 0.75s;
	}
	body {
  		font-family: "Roboto";
  		line-height: 1.4;
   		height: 100vh;
  		width: 100vw;
  		overflow: hidden;
	}
	ul{
	  	list-style-type: none;
	  	margin: 0;
	  	padding: 0;
	  	overflow: hidden;
	  	background-color: #333;
	  	margin-left:50px;
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
	img{
		height:250px;
		width:350px;
	}
	table{
		float:right;
		text-align:center;
		align:center;
		width:810px;
		margin-right:30px;
	}
	body{
        background-color: #bed1e4;
    }
    .mx-bugs_bunny{
        width: 600px;
        
        margin: 40px auto;
        height:1400px;
     }
     .ZI-slider{
        border: 4px solid #27425d;
     }
     .mx-bugs_info{
        position: absolute;
        display: block;
        padding: 10px;
        bottom: 40px;
        background-color: rgba(39, 66, 93, 0.9);
     }
     .mx-bugs_info a{
        font-family: 'Oswald', sans-serif;
        color: #fff;
        font-size: 18px;
        text-decoration: none;
     }
     .mx-navigation {
        margin: 4px;
        top: 47%;
     }
     .mx-prev, .mx-next{
        background-color: #27425d;
     }
     .mx-prev{
        background-image: url(img/arr_l.png);
        background-repeat: no-repeat;
        background-position: 2px 5px;
     }
     .mx-next{
        background-image: url(img/arr_r.png);
        background-repeat: no-repeat;
        background-position: 8px 5px;
     }
     .mx-nav_dots{
        top: 88%;
     }
     .mx-nav_dots span{
        margin: 0px 4px;
        border-radius: 50%;
        -moz-border-radius: 50%;
        -webkit-border-radius: 50%;
        border: 3px solid #27425d;
        background-color: #fff;
     }
     .mx-nav_dots span.dotActive{
        background-color: #27425d;
     }
     
</style>
</head>
<body>
	<div class='navigation'>
		<ul>
			<li><a href="index.html">诺亚词典</a></li>
			<li><a href="translation.html">诺亚翻译</a></li>
			<li><a href='friend.jsp' class="active">朋友圈</a></li>
			<li><a href='#'>关于我们</a></li>
		</ul>
	</div>
	<div class="menu-wrap">
        <input type="checkbox" class="toggler" />
        <div class="hamburger">
        	<div></div>
        </div>
        <div class="menu">
            <div>
                <ul>
                    <li><a href="share.jsp">照片分享</a></li>
                    <li><a href="#">随笔记录</a></li>
                    <li><a href="#">游戏专区</a></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="mx-bugs_bunny">
        <!-- Slider -->
        <div class="ZI-slider">
        	<% 
        		ResultSet rs = getResult.Select("select * from myphoto");
        		while(rs.next()) {
        	%>
            <div>
                <img src="Photo?id=<%=rs.getInt("id")%>" alt="" />
                <div class="mx-bugs_info">
                    <a href="#" target="_blank">
                        <%=rs.getString("photo_name") %>
                    </a>
                </div>
            </div>
            <% } %>
        </div>
        <!-- Slider -->
    </div>
    <div class="click">
    	
    </div>
    <script type="text/javascript">
        $(document).ready(function () {
            $('.ZI-slider').MxSlider({
                autoPlay: true,
                dots: true,
                timeSlide: 500
            });
        })
    </script>
</body>
</html>