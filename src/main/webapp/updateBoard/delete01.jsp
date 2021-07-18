<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.ac.kopo.kopo08.service.BoardServiceImpl, kr.ac.kopo.kopo08.service.BoardService,kr.ac.kopo.kopo08.domain.Board,java.util.List,kr.ac.kopo.kopo08.service.BoardItemService,kr.ac.kopo.kopo08.service.BoardItemServiceImpl" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");
		int id = Integer.parseInt(request.getParameter("boardId"));
		BoardService boardService = BoardServiceImpl.getInstance();
		BoardItemService boardItemService = BoardItemServiceImpl.getInstance();
		
		Board board = new Board();
		board.setId(id);
		boardItemService.delete(board);
		boardService.delete(board);
		response.sendRedirect("../index.jsp");
	%>
</body>
</html>