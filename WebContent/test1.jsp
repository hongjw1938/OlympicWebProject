<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="java.util.Base64"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link rel='stylesheet' href='resources/css/nv.d3.css'>
   	<link rel='stylesheet' href='resources/css/rNVD3.css'>
    
	<script src='resources/js/jquery-1.8.2.min.js' type='text/javascript'></script>
	<script src='resources/js/d3.v3.min.js' type='text/javascript'></script>
    <script src='resources/js/nv.d3.min-new.js' type='text/javascript'></script>
    <script src='resources/js/fisheye.js' type='text/javascript'></script>    
    <style>
    .rChart {
      display: block;
      margin-left: auto; 
      margin-right: auto;
      width: 800px;
      height: 500px;
    }  
    </style>
</head>
<body>
<h1>R 시각화 결과 표현하기</h1>
<hr>
<%
if(request.getAttribute("summercost") != null) {		
	byte src[] = (byte[])request.getAttribute("summercost");
%>
	<img src="
	   data:image/jpg;base64, <%= Base64.getEncoder().encodeToString(src) %>"
	   width="700" height="500" >
<%
} 
%>	

<hr>
${ top5summer }
<hr>
<%
if(request.getAttribute("worldmapsummer") != null) {		
	byte src[] = (byte[])request.getAttribute("worldmapsummer");
%>
	<img src="
	   data:image/jpg;base64, <%= Base64.getEncoder().encodeToString(src) %>"
	   width="700" height="500" >
<%
} 
%>	
</body>
</html>