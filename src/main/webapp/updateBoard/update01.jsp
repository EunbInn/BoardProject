<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.ac.kopo.kopo08.service.BoardServiceImpl, kr.ac.kopo.kopo08.service.BoardService,kr.ac.kopo.kopo08.domain.Board,java.util.List" %>
<%@ page import="kr.ac.kopo.kopo08.service.BoardItemServiceImpl,kr.ac.kopo.kopo08.service.BoardItemService,kr.ac.kopo.kopo08.domain.BoardItem,java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>보드판 수정</title>
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
</style>
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");
		String boardId = request.getParameter("boardId");
		int id = Integer.parseInt(boardId);
		BoardService boardService = BoardServiceImpl.getInstance();
		
		Board board = boardService.selectOne(id);
		String title = board.getTitle();
		title = title.replaceAll("&gt;",">");
		title = title.replaceAll("&lt;","<");
	%>
	<form method="post">
		<table border="1px solid black">
			<tr>
				<th colspan="2">게시판 수정</th>
			</tr>
			<tr>
				<th class="category">번호</th>
				<td class="content"><%=boardId%></td>
			</tr>
			<tr>
				<th class="category">게시판 이름</th>
				<td class="content">
					<input type="text" name="title" class="input-box" id="input-title" 
					placeholder="게시판 이름을 입력해주세요" maxlength="50" value="<%=title%>">
				</td>
			</tr>
		</table>
		<button class="btn" id="submit" formaction="./update02.jsp?boardId=<%=boardId%>">수정</button>
		<button class="btn" formaction="./delete01.jsp?boardId=<%=boardId%>">삭제</button>
		<button class="btn" id="back"><a href="../index.jsp">취소</a></button>
	</form>
	<script>
		$(function() {
			$('#submit').click(function() {
				var title = $('#input-title').val();
				
				if ($.trim(title) == "") {
					alert('게시판 이름을 입력해주세요');
					return false;
				} else {
					return true;
				}
		})
	</script>
</body>
</html>