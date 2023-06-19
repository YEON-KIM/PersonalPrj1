<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GALLERY-LIST</title>
<style>
	#gallery-area{
		display: grid;
		grid-template-columns: 1fr 1fr 1fr;
		place-items: center center;
	}
</style>
</head>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>


<main>
		
			<h1 style="color: white">갤러리 목록 조회</h1>
		

			<hr>

			<div id="gallery-area">
				<c:forEach items="${voList}" var="vo">
					<a href="${root}/gallery/detail/${vo.no}">
						<div>
							<img 
								width="100" 
								height="100" 
								src="${root}/resources/upload/gallery/${vo.changeName}" 
								alt="${vo.originName}"
							>
							<div>${vo.title}</div>
						</div>
					</a>
				</c:forEach>
			</div>
			<a class="btn btn-primary" href="${root}/gallery/write">작성하기</a>
</main>

</body>
</html>