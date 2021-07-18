<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.ac.kopo.kopo08.domain.Board, kr.ac.kopo.kopo08.domain.BoardItem, java.util.List, 
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
	String title = request.getParameter("title");
	String writer = request.getParameter("writer");
	String content = request.getParameter("content");
	int id = Integer.parseInt(request.getParameter("id"));
	
	title = title.replaceAll(">", "&gt;");
	title = title.replaceAll("<", "&lt;");
	content = content.replaceAll(">", "&gt;");
	content = content.replaceAll("<", "&lt;");
	
	BoardItemService bItemService = BoardItemServiceImpl.getInstance();
	BoardItem boardItem = new BoardItem();
	boardItem.setId(id);
	boardItem.setTitle(title);
	boardItem.setWriter(writer);
	boardItem.setContent(content);
	
	bItemService.update(boardItem);
	response.sendRedirect("../oneView.jsp?boardId=" + boardId +"&id=" + id + "&page=" + nowPage);
	%>

</body>
</html>