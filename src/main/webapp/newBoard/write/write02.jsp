<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.ac.kopo.kopo08.domain.Board, kr.ac.kopo.kopo08.domain.BoardItem, kr.ac.kopo.kopo08.service.BoardService,
	kr.ac.kopo.kopo08.service.BoardServiceImpl, kr.ac.kopo.kopo08.service.BoardItemService, kr.ac.kopo.kopo08.service.BoardItemServiceImpl"%>
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
	String writer = request.getParameter("writer");
	String content = request.getParameter("content");
	int boardId = Integer.parseInt(request.getParameter("boardId"));
	String nowPage = request.getParameter("page");
	String strId = request.getParameter("id");
	int id = 0;
	
	content = content.replaceAll(">", "&gt;");
	content = content.replaceAll("<", "&lt;");
	
	//out.println(title);
	/* insert data into boardItem */
	BoardItemService bItemService = BoardItemServiceImpl.getInstance();
	BoardItem boardItem;
	if (title != null) {
		//꺽쇠 바꿈
		title = title.replaceAll(">", "&gt;");
		title = title.replaceAll("<", "&lt;");
		
		boardItem = new BoardItem(title, writer, content, boardId);
		bItemService.create(boardItem);
		id = bItemService.getNewID();
	} else if (title == null){
		boardItem = new BoardItem(writer, content);
		BoardItem parent = new BoardItem();
		id = Integer.parseInt(strId);
		parent.setId(id);
		boardItem.setParent(parent);
		
		bItemService.create(boardItem);
	}
	
	response.sendRedirect("../oneView.jsp?boardId=" + boardId +"&id=" + id + "&page=" + nowPage);
	%>
</body>
</html>