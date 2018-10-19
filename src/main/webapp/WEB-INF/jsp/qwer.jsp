<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>

</head>
<body>
<%-- <h1>${hello}</h1> --%>
<div id="result"></div>
<script>
// 检测浏览器支持
if (typeof(Storage) !== "undefined") {
   
    console.log(sessionStorage.getItem("lastname"));
    document.getElementById("result").innerHTML = sessionStorage.getItem("lastname"); 
} else {
    document.getElementById("result").innerHTML = "Sorry, your browser does not support Web Storage...";
}
</script>
</body>
</html>
