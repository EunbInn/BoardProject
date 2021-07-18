<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.ac.kopo.kopo08.domain.Board, kr.ac.kopo.kopo08.domain.BoardItem, java.util.List, 
kr.ac.kopo.kopo08.service.BoardItemService, kr.ac.kopo.kopo08.service.BoardItemServiceImpl"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="board.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style>
	table {
		width: 850px;
		border-collapse: collapse;
		border: 2px solid black;
	}
	
	.category {
		width: 150px;
	}
	
	.content {
		text-align: left;
		padding:8px;
	}
	
	tr {
		border-bottom: 2px solid black;
	}

	.input-box {
		width: 700px;
	}
	
	#content {
		width: 700px;
		height: 500px;
		resize: none;
	}
</style>
</head>
<body>
	<%
	String title = "";
	String writer = "";
	String strDate = "";
	String content = "";
	
	request.setCharacterEncoding("UTF-8");
	String boardId = request.getParameter("boardId");
	String nowPage = request.getParameter("page");
	int id = Integer.parseInt(request.getParameter("id"));
	
	
	
	BoardItemService bItemService = BoardItemServiceImpl.getInstance();
	BoardItem boardItem = bItemService.selectOne(id);
	title = boardItem.getTitle();
	writer = boardItem.getWriter();
	strDate = boardItem.getDate();
	content = boardItem.getContent();
	
	title = title.replaceAll("&gt;", ">");
	title = title.replaceAll("&lt;", "<");
	content = content.replaceAll("&gt;", ">");
	content = content.replaceAll("&lt;", "<");
	%>
	<div id="content-wrap">
		<form method="post">
			<table border="1px solid black">
				<tr>
					<th colspan="2">글쓰기</th>
				</tr>
				<tr>
					<th class="category">번호</th>
					<td class="content"><%=id%></td>
				</tr>
				<tr>
					<th class="category">제목</th>
					<td class="content">
						<input type="text" name="title" class="input-box" id="input-title" placeholder="제목을 입력해주세요" 
						value="<%=title%>" maxlength="50">
					</td>
				</tr>
				<tr>
					<th class="category">작성자</th>
					<td class="content">
						<input type="text" name="writer" class="input-box" id="input-writer" placeholder="작성자" 
						value="<%=writer%>" maxlength="50">
					</td>
				</tr>
				<tr>
					<th class="category">일자</th>
					<td class="content"><%=strDate%></td>
				</tr>
		
				<tr>
					<th class="category">내용</th>
					<td class="content">
						<textarea name="content" id="content" placeholder="내용을 입력해주세요"><%=content%></textarea>
					</td>
				</tr>
			</table>
			<button class="btn" id="back"><a href="../oneBoard.jsp?boardId=<%=boardId%>&page=<%=nowPage%>">취소</a></button>
			<input type="submit" id="submit" class="btn" value="쓰기" formaction="./update02.jsp?boardId=<%=boardId%>&id=<%=id%>&page=<%=nowPage%>">
			<input type="submit" id="delete" class="btn" value="삭제" formaction="../delete/delete02.jsp?boardId=<%=boardId%>&id=<%=id%>&page=<%=nowPage%>">
		</form>
	</div>
	<script>
		function filter(str) {
			var filter = /^[가-힣ㄱ-ㅎa-zA-Z0-9]{2,}$/;
			if (filter.test(str)) {
				return true;
			} else {
				return false;
			}
		}
		
		$(function() {
			$('#submit').click(function() {
				var title = $('#input-title').val();
				var writer = $('#input-writer').val();
				var content = $('#content').val();
				console.log(title);
				
				if ($.trim(title) == "") {
					alert('제목을 입력해주세요');
					return false;
				}
				
				if ($.trim(writer) == "") {
					alert('작성자를 입력해주세요');
					return false;
				}
				
				if(!filter(writer)) {
					alert('작성자 명은 공백 없이 한글, 숫자, 영문 2자리 이상 작성해주세요');
					return false;
				}
				
				if ($.trim(content) == "") {
					alert('내용을 입력해주세요');
					return false;
				}
				
				if ($.trim(title) != "" && $.trim(article) != "" && $.trim(writer) != "" && filter(writer)) {
					return true;
				}
			});
		});
	</script>
</body>
</html>