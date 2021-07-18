<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.ac.kopo.kopo08.service.BoardServiceImpl, kr.ac.kopo.kopo08.service.BoardService,kr.ac.kopo.kopo08.domain.Board,java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");
		String title = request.getParameter("title");
		title = title.replaceAll(">","&gt;");
		title = title.replaceAll("<","&lt;");
		BoardService boardService = BoardServiceImpl.getInstance(); 
		
		Board board = new Board(title);
		boardService.create(board);
		int id = boardService.getNewID();
		response.sendRedirect("./oneBoard.jsp?boardId=" + id);
	%>

</body>
</html>