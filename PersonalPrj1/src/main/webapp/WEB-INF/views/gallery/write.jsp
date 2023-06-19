<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GALLEY-WRITE</title>
</head>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<main>
			
			<h1 style="color: white">갤러리 작성</h1>
			
			<form action="${root}/gallery/write" method="POST" enctype="multipart/form-data">
				
				<input type="text" name="title">
				<br />
				<textarea name="content"></textarea>
				<br />
				<input type="file" name="f">
				<br />
				<input type="submit" value="작성하기">
				
			</form>
			
</main>

</body>
</html>