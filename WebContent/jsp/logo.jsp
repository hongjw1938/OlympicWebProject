<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Base64, model.LogoVO" %>
<!DOCTYPE>
<html>
<head>
<meta charset=UTF-8>
<style>
	@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
	
	 h1{
	 	text-align : center;
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
	 
	 div {
	 	text-align : center;
	 }
	 
	 img {
	 	display:block;
	 	margin:auto;
	 }
</style>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lato">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>Logo Result</title>
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
<h1><b>로고 투표 결과</b></h1>
</div>
<%
	if(request.getAttribute("img_content") != null) {
		byte src[] = (byte[])request.getAttribute("img_content");
%>
<img src="data:image/jpg;base64, <%= Base64.getEncoder().encodeToString(src) %>" width="900" height="700">
<%
	}
%>
</body>
</html>