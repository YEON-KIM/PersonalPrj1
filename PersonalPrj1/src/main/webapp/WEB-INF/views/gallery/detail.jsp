<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GALLEY-DETAIL</title>

<style>
		.view-area , .form-area {
			display: none;
		}
		.active{
			display: block;
		}
	</style>

</head>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<main>

			<div class="view-area active">
				<h1 style="color: white">갤러리 상세조회</h1>
				
				<div style=" background-color: white">${vo.title}</div>
				<img src="${root}/resources/upload/gallery/${vo.changeName}" width="800px" height="800px" >
				<div style="background-color: white">${vo.content }</div>
				
				<hr>
				
				<c:if test="${ loginMember.no eq vo.writerNo }">
					<a class="btn btn-warning" href="javascript:changeView();">수정</a>
					<a class="btn btn-danger" href="${root}/gallery/del/${vo.no}/${vo.changeName}">삭제</a>
				</c:if>
			</div>

			<div class="form-area">
				<h1 style="color: white">갤러리 수정하기</h1>
			
				<form action="${root}/gallery/edit" method="post" enctype="multipart/form-data">

					<input type="hidden" name="no" value="${vo.no}">
					<br />
					<input type="text" name="title" value="${vo.title}">
					<br />
					<textarea name="content">${vo.content}</textarea>
					<br />
					<div style=" background-color: white">기존 파일명 : ${vo.originName}</div>
					<br />
					<div style=" background-color: white">수정할 파일 (수정안할거면 그냥 두셔도 됩니다.) : <input type="file" name="f"></div>
					<br />
					<input type="submit" value="수정하기">
				</form>
			</div>

			
		</main>
		
		
	<script>
		function changeView(){
			//viewArea 액티브 클래스 제거
			const viewArea = document.querySelector('.view-area');
			viewArea.classList.remove('active');
			
			//formArea 액티브 클래스 추가
			const formArea = document.querySelector('.form-area');
			formArea.classList.add('active');
		}
	</script>
</body>
</html>