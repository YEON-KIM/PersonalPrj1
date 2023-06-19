<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BOARD-WRITE</title>

<style type="text/css">
.note-editable {
    background-color: white;
}
</style>




<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>



<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
</head>
<body>


<%@ include file="/WEB-INF/views/common/header.jsp" %>

<h1 style="color: white">글 작성</h1>

 <br>
   <form action="/app/board/write" method="post">
      <input type="text" name="title">
      <label>주제</label>
					<select name="categoryNo">
						<option>없음</option>
						<option value="10">자유</option>
						<option value="20">작업</option>
						<option value="30">코딩</option>
					</select>
      <textarea id="summernote" name="content" ></textarea>
      <input type="submit" value="작성" class="btn btn-primary">
     <a href="${root }/board/list" class="btn btn-primary">취소</a>
      
   </form>
   
   

   
   
   
   
   
   
    <script>
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
          url : 'app/upload' ,
          type : 'post' ,
          data : fd ,
          processData : false ,
          contentType : false ,
          dataType : 'json' ,
          success : function(changeNameList){
            console.log(changeNameList);

            for(let changeName of changeNameList){
              $("#summernote").summernote('insertImage' , 'app/resources/img/' + changeName);
            }

          } ,
          error : (error)=>{
            console.log(error);
          } ,
        });
      }






    </script>



</body>
</html>