<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.ac.kopo.kopo08.domain.Board, kr.ac.kopo.kopo08.domain.BoardItem,
kr.ac.kopo.kopo08.service.BoardItemService, kr.ac.kopo.kopo08.service.BoardItemServiceImpl"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");
	String boardId = request.getParameter("boardId");
	String nowPage = request.getParameter("page");
	int id = Integer.parseInt(request.getParameter("id"));
	
	BoardItemService boardItemService = BoardItemServiceImpl.getInstance();
	BoardItem boardItem = new BoardItem();
	boardItem.setId(id);
	
	boardItemService.delete(boardItem);
	
	response.sendRedirect("./delete02.jsp?boardId=" + boardId + "&page=" + nowPage);
	%>
</body>
</html>