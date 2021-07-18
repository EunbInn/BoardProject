<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.ac.kopo.kopo08.service.BoardServiceImpl, kr.ac.kopo.kopo08.service.BoardService,kr.ac.kopo.kopo08.domain.Board,java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>보드판 수정</title>
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");
		String title = request.getParameter("title");
		int id = Integer.parseInt(request.getParameter("boardId"));
		title = title.replaceAll(">","&gt;");
		title = title.replaceAll("<","&lt;");
		BoardService boardService = BoardServiceImpl.getInstance(); 
		
		Board board = new Board(id, title);
		boardService.update(board);
		response.sendRedirect("../index.jsp");
	%>

</body>
</html>