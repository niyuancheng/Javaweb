<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.*,java.io.*,Function.Connect,Function.getResult" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>在此处上传你的图片</title>
<link href="css/menu.css" rel="stylesheet" />
<link href="css/uploadImg.css" rel="stylesheet" />
<link rel="stylesheet" href="https://at.alicdn.com/t/font_1805932_ysrcp4y0uy9.css">
<link rel="stylesheet" href="./bootstrap-3.4.1-dist/css/bootstrap.min.css" />

<script src="./Jquery/jquery-3.5.1.js"></script>
<script src="./bootstrap-3.4.1-dist/js/bootstrap.min.js"></script>
<script src="./javascript/clickheart.js"></script>
<script>
var imgFile = []; //文件流,用于将图片存储到数据库中
var imgSrc = []; //图片路径
var imgName = []; //图片名字
var count = 0;
<% ResultSet rs = getResult.Select("select * from myphoto"); %>
$(function() {
	<%
		while(rs.next()) {
	%>
	count++;
	imgSrc.push("Photo?id="+<%=rs.getInt("id") %>);
	var imgbox = ".content-img-list";
	
	var oldImg = $(imgbox).html();
	$(imgbox).html(oldImg+'<li class="content-img-list-item"><img src="Photo?id=' + <%=rs.getInt("id") %> + '" alt="">' +
            '<div class="hide"><a index="' + <%=rs.getInt("id") %> + '" class="delete-btn"><i class="gcl gcllajitong"></i></a>' +
            '<a index="' + <%=rs.getInt("id") %> + '" class="big-btn" type="button" data-toggle="modal" data-target=".bs-example-modal-lg"><i class="gcl gclfangda"></i></a></div></li>');
	<% } %>
	
    // 鼠标经过显示删除按钮
    $('.content-img-list').on('mouseover', '.content-img-list-item', function() {
        $(this).children('div').removeClass('hide');
    });
    // 鼠标离开隐藏删除按钮
    $('.content-img-list').on('mouseleave', '.content-img-list-item', function() {
        $(this).children('div').addClass('hide');
    });
    // 单个图片删除
    $(".content-img-list").on("click", '.content-img-list-item a .gcllajitong', function() {
        var index = $(this).parent().parent().parent().index();
        imgSrc.splice(index, 1);
        imgFile.splice(index, 1);
        imgName.splice(index, 1);
        var boxId = ".content-img-list";
        addNewContent(boxId);
        if (imgSrc.length < 4) { //显示上传按钮
            $('.content-img .file').show();
        }
    });

    //查看某个具体图片
    $(".content-img-list").on("click", '.content-img-list-item a .gclfangda', function() {
        var index = $(this).parent().parent().parent().index();
        $(".modal-content").html("");

        var bigimg = $(".modal-content").html();
        $(".modal-content").html(bigimg + '<div class="show"><img src="' + imgSrc[index] + '" alt=""><div>');
        // $(".modal-content").append(
        //     '<div class="show"><img src="' + imgSrc[a] + '" alt=""><div>'
        // );
    });
    $('#upload').on('change', function(e) {
    	//imgSrc = [];
    	imgFile = [];
        var imgSize = this.files[0].size;
        var imgBox = '.content-img-list';
        var fileList = this.files;
        for (var i = 0; i < fileList.length; i++) {
            var imgSrcI = getObjectURL(fileList[i]);
            imgName.push(fileList[i].name);
            imgSrc.push(imgSrcI);
            imgFile.push(fileList[i]);
            count++;
        }
        addNewContent(imgBox);
        this.value = null; //上传相同图片
        alert("照片上传成功");   
        //以下代码为将图片上传至后端并且保存到数据库中
        var formFile = new FormData(); 
       	for(var i = 0;i<imgFile.length;i++){
       		formFile.append("myFile",imgFile[i]);
       		
       	}
       	
        $.ajax({
        	url:"SavePhoto",
        	type:"POST",
        	data:formFile,
        	async: true,
        	cache: false,
        	contentType: false,
        	processData: false,
        	dataType:'json',
        	success:function(res){
        		alert("上传照片成功");
        	},
        });
	});
});
//图片上传

//删除
function removeImg(obj, index) {
        imgSrc.splice(index, 1);
        imgFile.splice(index, 1);
        imgName.splice(index, 1);
        //count--;
        var boxId = ".content-img-list";
        addNewContent(boxId);
}
//图片展示
function addNewContent(obj) {
        // console.log(imgSrc)
        for (var a = count - imgFile.length ; a < imgSrc.length; a++) {
            var oldBox = $(obj).html();
            $(obj).html(oldBox + '<li class="content-img-list-item"><img src="' + imgSrc[a] + '" alt="">' +
                '<div class="hide"><a index="' + a + '" class="delete-btn"><i class="gcl gcllajitong"></i></a>' +
                '<a index="' + a + '" class="big-btn" type="button" data-toggle="modal" data-target=".bs-example-modal-lg"><i class="gcl gclfangda"></i></a></div></li>');
        }
}
   

    //建立可存取到file的url
function getObjectURL(file) {
        var url = null;
        if (window.createObjectURL != undefined) { // basic
            url = window.createObjectURL(file);
        } else if (window.URL != undefined) { // mozilla(firefox)
            url = window.URL.createObjectURL(file);
        } else if (window.webkitURL != undefined) { // webkit or chrome
            url = window.webkitURL.createObjectURL(file);
        }
        return url;
}


</script>
</head>
<body>
	<div class="menu-wrap">
        <input type="checkbox" class="toggler" />
        <div class="hamburger">
        	<div></div>
        </div>
        <div class="menu">
            <div>
                <ul>
                	<li><a href="friend.jsp">返回上页</a></li>
                    <li><a href="share.jsp">照片分享</a></li>
                    <li><a href="#">随笔记录</a></li>
                    <li><a href="#">游戏专区</a></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="main">
        <div class="upload-content">
            <h3>上传图片</h3>
            <div class="content-img">
                <ul class="content-img-list"></ul>
                <div class="file">
                    <i class="gcl gcladd"></i>
                    <form method="post" enctype="multipart/form-data" >
                    	<input type="file" name="file" accept="image/*" id="upload" multiple>
                    </form>
                </div>
            </div>

            <div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">

                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>