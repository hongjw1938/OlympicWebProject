<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.ArrayList, model.NewsVO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lato">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>board</title>
<style>
@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
	
	 h1{
	 	text-align : center;
	 	/*     font-family: 'Hanna', sans-serif; */
	 	font-family: 'Jeju Gothic', sans-serif;
	 	font-size:35pt;
	 	letter-spacing : 30px;
	 }
	 
	 tr:nth-child(even){
    	background : aliceblue;
    }
    
    .container-fluid {
    	padding-top: 70px;
    	padding-bottom: 70px;
 	}
 	
 	.bg-1 { 
    	background-color: #6eb5c0; /* gold */
    	color: #ffffff;
    }	
    
    body {
    	margin-right : auto;
    	margin-left : auto;
  	/* text-align : center;  */
 	}
 	
 	input[type=text] {
		margin : 2px;
		padding-top: 2px;
	} 
	
	textarea {
		margin : 3px;
		padding-top: 3px;
	}

 	table {
    	margin-right : auto;
    	margin-left : auto;
    	text-align : center;
    	heigth : 50px;
    }

	td {
	    padding : 5px;
	    text-align : center;
	    font-family: 'Jeju Gothic', sans-serif;
	 }
	
	th {
	    padding : 5px;
	    text-align : center;
	    border-bottom:1px solid gray;
	    font-family: 'Jeju Gothic', sans-serif;
	}
	
	tbody tr:nth-child(even){
	    background-color : #d9ecff;
	}
	 
	#write {
	    display:none;
	} 
	
	div{
	    text-align : center;
	}
	
	st {
	    position : absolute;
	    right:180px;
	}
	 
	sr {
	    position : absolute;
	    right:250px;
	}
</style>
</head>
<body>
<div class="w3-top">
  <div class="w3-bar w3-blue w3-card-2">
    <a class="w3-bar-item w3-button w3-padding-large w3-hide-medium w3-hide-large w3-right" href="javascript:void(0)" onclick="myFunction()" title="Toggle Navigation Menu"><i class="fa fa-bars"></i></a>
    <a href="/project/html/main.html" class="w3-bar-item w3-button w3-padding-large">HOME</a>
    <a href="https://hongjw1991.shinyapps.io/olympicproject/" class="w3-bar-item w3-button w3-padding-large w3-hide-small">CHARTS</a>
    <a href="/project/news.do" class="w3-bar-item w3-button w3-padding-large w3-hide-small">BOARD</a>
    <div class="w3-dropdown-hover w3-hide-small">
      <button class="w3-padding-large w3-button" title="More">VOTE <i class="fa fa-caret-down"></i></button>     
      <div class="w3-dropdown-content w3-bar-block w3-card-4">
        <a href="/project/html/mascot.html" class="w3-bar-item w3-button">역대 마스코트</a>
        <a href="/project/html/logo.html" class="w3-bar-item w3-button">역대 올림픽마크</a>
      </div>
    </div>
  </div>
</div>
<div class="container-fluid bg-1 text-center">
<h1 style = 'text-align : center','text-shadow : 3px 3px solid gray'>자유 게시판</h1>
</div>
<table>
 <thead>
  <tr><th>no.</th><th width = "600">제목</th><th width = "75">작성자</th><th width = "120">작성일</th><th>조회수</th></tr>
 </thead>
<%
ArrayList<NewsVO>list = (ArrayList<NewsVO>)request.getAttribute("list");
if(list != null) {
%>

<tbody>
<%	
	for(NewsVO vo : list) {
%>
    <tr>
     <td><%= vo.getId() %></td>
     <td width = "500" onclick="location.href='/project/news.do?action=read&newsid=<%= vo.getId() %>'" ><%= vo.getTitle() %></td>
     <td width = "70"><%= vo.getWriter() %></td>
     <td width = "100"><%= vo.getWritedate() %></td>
     <td><%= vo.getCnt() %></td>
    </tr>
<%
	}
%>
</tbody>
</table>
<sr><button class="btn btn-info btn-md" onclick = "location.href='/project/news.do'">목록</button></sr>
<st><button class="btn btn-info btn-md" onclick = "show('write')">글쓰기</button></st>
<div id="write" style='padding:30px'>
 <form action="/project/news.do" method="post" > 
 <input type="text" name="writer" placeholder="작성자명을 입력해주세요" size = "90" required><br>
 <input type="text" name="title" placeholder="제목을 입력해주세요" size = "90" required><br>
 <textarea name="content" cols = "91" rows = "7" placeholder="내용을 입력해주세요" required></textarea><br>
 <input type="submit" value="저장">
 <input type="hidden" name="action" value="insert">
 <input type="reset" value="재작성">
 <input type="button" value="취소" onclick="closeform('write')">
</form>
</div>
<%
NewsVO vo = (NewsVO)request.getAttribute("vo");
if(vo != null){
%>
<div id="show" style='padding:50px'>
 <form action="/project/news.do" method="post">
  <input type="text" name="writer" value="${ vo.writer }" size = "90" required><br>
  <input type="text" name="title" value="${ vo.title }" size = "90" required><br>
  <textarea name="content" cols = "100" rows = "10" required>${ vo.content }</textarea><br>
  <input  type="button" value="삭제" onclick="location.href='/project/news.do?action=delete&newsid=${ vo.id }'">
  <input type="submit" value="수정">
  <input type="hidden" name="action" value="update">
  <input type="hidden" name="newsid" value="${ vo.id }">
  <input type="button" value="확인" onclick="closeform('show')"> 
 </form>
</div>
<%
 }
}
%>
<script>
function show(obj){
	document.getElementById(obj).style.display = "block";
    if(obj == "write")
    	document.getElementById("show").style.display = "none";
}

function closeform(obj){
	document.getElementById(obj).style.display = "none";
}
</script>
</body>
</html>