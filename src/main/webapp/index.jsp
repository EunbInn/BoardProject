<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.ac.kopo.kopo08.service.BoardServiceImpl, kr.ac.kopo.kopo08.service.BoardService,kr.ac.kopo.kopo08.domain.Board,java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="board.css">
<link rel="stylesheet" type="text/css" href="index.css">
<style>
	#title {
		width: 650px;
	}
</style>
</head>
<body>
	<div id="content-wrap">
		<h1>게 시 판</h1>
		<table>
			<tr>
				<th>게시판 번호</th>
				<th id="title">제목</th>
				<th>관리</th>
			</tr>
			<%
			BoardService boardService = BoardServiceImpl.getInstance();
					
					List<Board> boardList = boardService.selectAll();
				
					if (boardList.size() == 0) {
						out.println("<tr><td colspan='3'>생성된 게시판이 없습니다</td></tr>");
					} else {
						for (int i = 0; i < boardList.size(); i++) {
							Board board = boardList.get(i);
							out.println("<tr>" +
										"<td>" + board.getId() + "</td>" +
										"<td><a href='./newBoard/oneBoard.jsp?boardId=" + board.getId() + "'>" + board.getTitle() + "</a></td>" + 
										"<td><a href='./updateBoard/update01.jsp?boardId=" + board.getId() + "'>수정</td>" +
										"</tr>");
						}
					}
			%>
		</table>
		<button class="btn" onclick="location.href='./newBoard/newBoard.jsp'">게시판 생성</button>
	</div>
</body>
</html>