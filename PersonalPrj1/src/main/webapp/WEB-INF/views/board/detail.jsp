<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BOARD-DETAIL</title>
<style type="text/css">
.note-editable {
    background-color: white;
}

.view-area, .form-area{
	display: none;
}
.active{
	display: block;
}

</style>



<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>



<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
</head>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<main>


		<div class="view-area active">

			<h1 style="color: white">게시글 상세조회</h1>

			<!-- 내용 -->

			<form action="${root}/board/write" method="POST">
				<div>${bvo.title }</div>
			    <div id="summernote1">${bvo.content }</div>
			</form>
			
			<!-- 수정/삭제/ -->
			
			<div>
			<c:if test="${loginMember.no eq bvo.writerNo}">
				<a href="javascript:changeView();" type="button" class="btn btn-sm btn-primary" id="btnList">수정하기</a>
				<a  href="${root}/board/delete?no=${bvo.no } " class="btn btn-sm btn-primary"  style="background-color: red">삭제</a>			
			</c:if>
				<a href="${root}/board/list" type="button" class="btn btn-sm btn-primary" id="btnList">목록</a>
			</div>
			
			
			
			<div id="comment-header">
				<input type="text" name="comment" placeholder="댓글을 입력하세요">
				<button onclick="writeComment();" class="btn btn-primary btn-sm">댓글작성</button>
			</div>
			<div id="comment-area">
				
			</div>
		</div>
		
		
	<div class="form-area">
		<h1 style="color: white">게시글 수정</h1>
		
	<form action="/app/board/edit" method="post">
	
	  <input type="hidden" name="no" value="${bvo.no }">
      <input type="text" name="title" value="${bvo.title }">
      <input type="hidden" name="writerNo" value="${loginMember.no }">
      <label>주제</label>
					<select name="categoryNo">
						<option>없음</option>
						<option value="10">자유</option>
						<option value="20">작업</option>
						<option value="30">코딩</option>
					</select>
      <textarea id="summernote" name="content" >${bvo.content }</textarea>
      
      <c:if test="${loginMember.no eq bvo.writerNo}">
      
      <input type="submit" value="수정완료" class="btn btn-sm btn-primary">
      
	  <a href="${root }/board/detail?no=${bvo.no}" class="btn btn-sm btn-primary">취소</a>
      </c:if>
      <a href="${root }/board/list" class="btn btn-sm btn-primary">목록</a>
      
   </form>
		
		
	</div>
		
		
</main>

</body>
</html>



<script>
//수정 화면 전환
function changeView(){
	//viewArea 액티브 클래스 제거
	const viewArea = document.querySelector('.view-area');
	viewArea.classList.remove('active');
	
	//formArea 액티브 클래스 추가
	const formArea = document.querySelector('.form-area');
	formArea.classList.add('active');
}



//수정 써머노트

$('#summernote').summernote({
        placeholder: '내용을 적어주세요',
        tabsize: 2,
        height: 500,
        width: 1300,
        callbacks : {
        	onImageUpload : f01
        },
        toolbar: [
          ['style', ['style']],
          ['font', ['bold', 'underline', 'clear']],
          ['color', ['color']],
          ['para', ['ul', 'ol', 'paragraph']],
          ['table', ['table']],
          ['insert', ['link', 'picture', 'video']],
          ['view', ['fullscreen', 'codeview', 'help']]
        ]
      });



      function f01(fileList) {
		console.log(fileList);
	  const fd = new FormData();

    for(let file of fileList){
      fd.append('fileList', file);

    }

	  $.ajax({
          url : '/app/upload' ,
          type : 'post' ,
          data : fd ,
          processData : false ,
          contentType : false ,
          dataType : 'json' ,
          success : function(changeNameList){
            console.log(changeNameList);

            for(let changeName of changeNameList){
              $("#summernote").summernote('insertImage' , '/app/resources/img/' + changeName);
            }

          } ,
          error : (error)=>{
            console.log(error);
          } ,
        });
      }













//서머노트

$('#summernote1').summernote({
	airMode : true
});




	const div = document.querySelector('#thumbnail-area');
	
	let imgTag;
	let aTag;
	<c:forEach items="${bvo.attList}" var="fvo">
		//a태그 만들기
		aTag = document.createElement('a');
		aTag.href = "${root}/board/att/down?ano=${fvo.no}";
		//이미지 요소 만들기
		imgTag = document.createElement('img');
		imgTag.setAttribute("src" , "${root}/${path}/${fvo.changeName}");
		imgTag.setAttribute("alt" , "${fvo.originName}");
		imgTag.setAttribute("width" , "100px");
		imgTag.setAttribute("height" , '100px');

		//a태그 내부에 img 추가
		aTag.appendChild(imgTag);

		//div 안에 a태그 추가
		div.appendChild(aTag);
	</c:forEach>



	function writeComment(){
		//로그인 안되어있으면 ㄴㄴ
		const writerNo = '${loginMember.no}';
		if(writerNo <= 0){
			alert("로그인 후 작성 가능합니다.");
			return;
		}

		//ajax 이용해서 서버에 댓글내용 보내기
		const content = document.querySelector('input[name=comment]').value;
		
		$.ajax({
			url : '${root}/board/reply/write' ,
			type : 'POST' ,
			data : {
				'bno' : '${bvo.no}' ,
				'content' : content ,
			} , 
			success : function(data){
				if(data == 'ok'){
					alert("댓글 작성 완료 !");
					document.querySelector('input[name=comment]').value = '';
					loadReply();
				}else if(data == 'unauthor'){
					alert("로그인 후 작성 가능합니다.");
				}else{
					alert("댓글 작성 실패 ...");
				}
			} , 
			error : function(){
				alert('bad...');
			} ,
		});
	}
	


	//댓글 불러오기
	loadReply();

	function loadReply(){

		const commentArea = document.querySelector('#comment-area');
		commentArea.innerHTML = '';
		const writerNo = '${loginMember.no}';

		$.ajax({
			url : '${root}/board/reply/list' ,
			type  : 'get' ,
			data : {
				'bno' : '${bvo.no}'	
			} ,
			dataType : 'json' ,
			success : function(data){
				console.log(data);

				for(let replyVo of data){
					let str = "";
					str += "<div>";
					str += replyVo.content;
					str += "</div>";
					str += "<div>";
					str += "<span>"
					str += replyVo.writerNick;
					str += "</span>"
					if(writerNo == replyVo.writerNo || writerNo == 1 ){
						str += "<button class='btn btn-warning btn-sm' onclick='editReply(" + replyVo.no + ");'>수정</button>";
						str += "<button class='btn btn-danger btn-sm' onclick='deleteReply(" + replyVo.no + ");'>삭제</button>";
					}
					str += "</div>";
					commentArea.innerHTML += str;
				}

			} ,
			error : function(error){
				console.log(error);
			} ,
		});

	}

	
	//댓글 삭제 함수
	function deleteReply(rno){
		
		const result = confirm("삭제하시겠습니까?");
		if(!result){
			return;
		}

		$.ajax({
			url : '${root}/board/reply/delete?rno=' + rno ,
			type : 'delete' ,
			// data : {
			// 	'rno' : rno
			// } ,
			success : function(data){
				console.log(data);
				alert("삭제 완료");
				loadReply();
			} ,
			error : function(error){
				console.log(error);
				alert("삭제 실패");
			} ,
		});

	}

	//댓글 수정 함수
	function editReply(rno){
		//댓글번호 , 수정할내용
		const newContent = window.prompt("수정할 내용을 입력하세요");

		//수정 요청 보내기
		$.ajax({
			url : '${root}/board/reply/edit' , 
			type : 'post' , 
			data : {
				content : newContent ,
				no : rno ,
			} , 
			success : function(data){
				alert("수정 완료");
				loadReply();
			} , 
			error : function(error){
				alert("수정 실패");
			} , 
		});

	}


</script>














