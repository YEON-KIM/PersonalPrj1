<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BOARD-LIST</title>
<style type="text/css">
	body {
  background: #f5f5f5
}

table {
  margin-bottom : 30px;
  border: 1px #a39485 solid;
  font-size: .9em;
  box-shadow: 0 2px 5px rgba(0,0,0,.25);
  width: 100%;
  border-collapse: collapse;
  border-radius: 5px;
  overflow: hidden;
}

th {
  text-align: left;
}
  
thead {
  font-weight: bold;
  color: #fff;
  background: #73685d;
}
  
 td, th {
  padding: 1em .5em;
  vertical-align: middle;
}
  
 td {
  border-bottom: 1px solid rgba(0,0,0,.1);
  background: #fff;
}

a {
  color: #73685d;
}

#write-btn-area{
	margin-bottom : 30px;
	float: right;
}

#page-area{
	width:600px;
		margin: auto;
		display: flex;
		justify-content: center;
}





  
 @media all and (max-width: 768px) {
    
  table, thead, tbody, th, td, tr {
    display: block;
  }
  
  th {
    text-align: right;
  }
  
  table {
    position: relative; 
    padding-bottom: 0;
    border: none;
    box-shadow: 0 0 10px rgba(0,0,0,.2);
  }
  
  thead {
    float: left;
    white-space: nowrap;
  }
  
  tbody {
    overflow-x: auto;
    overflow-y: hidden;
    position: relative;
    white-space: nowrap;
  }
  
  tr {
    display: inline-block;
    vertical-align: top;
  }
  
  th {
    border-bottom: 1px solid #a39485;
  }
  
  td {
    border-bottom: 1px solid #e5e5e5;
  }
  
  
  }

</style>
</head>
<body>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<br><br>			<h1 style="color: white">게시글 목록</h1>
<br><br><br>

<form action="${root}/board/list" method="get">
		<div id="search-area">
			<select name="searchType">
				<option value="title">제목</option>
				<option value="content">내용</option>
				<option value="category">카테고리</option>
			</select>
				<input type="text" name="searchValue" value="${searchMap.searchValue}" placeholder="검색할값을 입력하세요">
			<select class="hide" name="searchValue">
				<c:forEach items="${cvoList}" var="cvo">
					<option value="${cvo.NO}">${cvo.NAME}</option>
				</c:forEach>
			</select>
				<input type="submit" value="검색하기" class="btn btn-primary">
		</div>
</form>

<table>
    <thead>
    <tr>
        <th>NO</th>
        <th>TITLE</th>
        <th>NICK</th>
        <th>VIEWS</th>
        <th>TIME</th>
  
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${bvoList}" var="bvo">
    <tr>
        <td>${bvo.no }</td>
        <td>${bvo.title }</td>
        <td>${bvo.writerName }</td>
        <td>${bvo.hit }</td>
        <td>${bvo.enrollDate }</td>
    </tr>
    </c:forEach>
    </tbody>
</table>



<c:if test="${not empty loginMember}">
				<div id="write-btn-area">
					<a class="btn btn-primary" href="${root}/board/write">WRITE</a>
				</div>
			</c:if>

			<div id="page-area">
				<c:if test="${pv.currentPage > 1}">
					<a href="${root}/board/list?page=${pv.currentPage-1}&searchType=${searchMap.searchType}&searchValue=${searchMap.searchValue}" class="btn btn-secondary btn-sm">이전</a>
				</c:if>
				<c:forEach begin="${pv.startPage}" end="${pv.endPage}" step="1" var="i">
					<a href="${root}/board/list?page=${i}&searchType=${searchMap.searchType}&searchValue=${searchMap.searchValue}" class="btn btn-secondary btn-sm" >${i}</a>
				</c:forEach>
				<c:if test="${pv.currentPage < pv.maxPage}">
					<a href="${root}/board/list?page=${pv.currentPage+1}&searchType=${searchMap.searchType}&searchValue=${searchMap.searchValue}" class="btn btn-secondary btn-sm">다음</a>
				</c:if>
			</div>





</body>
</html>





<script>
	
	// 변수 준비
	const searchTypeTag = document.querySelector('select[name="searchType"]');
	const svInput = document.querySelector('input[name="searchValue"]');
	const svSelect = document.querySelector('select[name="searchValue"]');

	//서치타입 초기값 셋팅
	function initSearchType(){
		const optionTag = document.querySelector('option[value="${searchMap.searchType}"]');
		if(optionTag != null){
			optionTag.selected = true;
		}
	}
	
	//서치밸류 형태 변경
	function toggleSearchValueTag(){
		if(searchTypeTag.value != 'category'){
			showNotCategory();
		}else{
			showCategory();
		}
	}

	//서치밸류 형태1
	function showNotCategory(){
		//인풋 태그가 보이게
		svInput.classList.remove('hide');
		svInput.name = 'searchValue';
		svSelect.classList.add('hide');
		svSelect.name = 'xxx';
		
		svInput.value = '';
	}
	
	//서치밸류 형태2
	function showCategory(){
		//셀렉트 태그가 보이게
		svInput.classList.add('hide');
		svInput.name = 'xxx';
		svSelect.classList.remove('hide');
		svSelect.name = 'searchValue';
	}
	
	//서치밸류 형태 초기셋팅
	function initSearchValueType(){
		if('${searchMap.searchType}' == 'category'){
			showCategory();
		}else{
			showNotCategory();
		}
	}
	
	//서치밸류 selected 셋팅
	function initSearchValueSelected(){
		const optionTag = document.querySelector('option[value="${searchMap.searchValue}"]');
		if(optionTag != null){
			optionTag.selected = true;
		}
	}
	
	//input태그 (서치밸류) 값 초기셋팅
	function initSearchValueInput(){
		svInput.value = '${searchMap.searchValue}';
	}
	
	initSearchValueSelected();
	initSearchType();
	initSearchValueType();
	initSearchValueInput();
	
	//이벤트 리스너 //서치밸류 형태 변경하는 이벤트 등록
	searchTypeTag.addEventListener('change' , toggleSearchValueTag);
	
	
	//행 클릭했을 때 , 상세조회
	const tbody = document.querySelector(' table > tbody ');
	tbody.addEventListener("click" , (event)=>{
		const no = event.target.parentNode.children[0].innerText;
		location.href = '${root}/board/detail?no=' + no;
	});

	
	
</script>














