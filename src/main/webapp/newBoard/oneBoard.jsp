<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.ac.kopo.kopo08.service.BoardItemServiceImpl, kr.ac.kopo.kopo08.service.BoardItemService,
		kr.ac.kopo.kopo08.domain.BoardItem, java.util.List" %>
<%@ page import="kr.ac.kopo.kopo08.service.BoardServiceImpl, kr.ac.kopo.kopo08.service.BoardService,kr.ac.kopo.kopo08.domain.Board" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="board.css">
<link rel="stylesheet" type="text/css" href="index.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style>
	#back-index {
		text-align: left;
		text-decoration: none;
		color: black;
	}

	#back-index:hover {
		text-decoration: underline;
		color: red;
	}
	
	#find-box {
		text-align: right;
		margin-bottom: 10px;
	}
	
	#find {
		height: 20px;
	}
	
	#submit {
		height: 26px;
	}
	
	select {
		height: 26px;
	}
	
	#page-box {
		display: flex;
		justify-content: center;
	}
	
	.page {
		display: inline-block;
		margin: 10px;
		text-decoration: none;
		color: black;
	}
	
	.selected {
		font-weight: bold;
	}
</style>
</head>
<body>
	<div id="content-wrap">
		<a href="../index.jsp" id="back-index">&lt;&lt;게시판 목록</a>
		<%
		request.setCharacterEncoding("UTF-8");
		int boardId = Integer.parseInt(request.getParameter("boardId"));
		String find = request.getParameter("find");
		String findType = request.getParameter("findType");

		BoardItemService boardItemService = BoardItemServiceImpl.getInstance();
		BoardService boardService = BoardServiceImpl.getInstance();
		Board board = boardService.selectOne(boardId);

		List<BoardItem> boardList = null;
		if (find != null) {
			boardList = boardItemService.selectChoice(boardId, find, findType);
		} else {
			boardList = boardItemService.selectAll(boardId);
		}
		%>
		<h1><%=board.getTitle() %></h1>
		<div id="find-box">
			<form method="post">
				<select name="findType">
					<option value="title">제목</option>
					<option value="writer">작성자</option>
					<option value="title+writer">제목+작성자</option>
				</select>
				<input id="find" name="find" type="text" maxlength="30" placeholder="검색어 입력">
				<input type="submit" id="submit" formaction="./oneBoard.jsp?boardId=<%=boardId%>" value="검색">
			</form>
		</div>
		<table>
			<tr>
				<th>번호</th>
				<th id="title">제목</th>
				<th>작성자</th>
				<th>작성 일자</th>
			</tr>

			<%
			int nowPage = 0;
			try {
				nowPage = Integer.parseInt(request.getParameter("page"));
			} catch (Exception e) {
				nowPage = 1;
			}

			int onePage = 10; //한 페이지에 보여줄 개수
			int totalPage = (boardList.size() / onePage) + ((boardList.size() % onePage) > 0 ? 1 : 0); // 총 페이지수

			int maxPage = 10; //한번에 보여줄 페이지 버튼 수
			int endList = nowPage * onePage;
			int startList = endList - 9;
			int nowGroup = (nowPage / maxPage) + ((nowPage % maxPage) > 0 ? 1 : 0); // 현재 페이지가 속한 그룹
			int gEnd = nowGroup * maxPage; //페이지 그룹의 마지막페이지
			int gStart = (nowGroup * maxPage) - 9; //그룹의 첫페이지
			int previous = nowPage - 1;
			int next = nowPage + 1;
			int firstPage = 1;
			int lastPage = totalPage;

			if (previous <= firstPage) {
				previous = firstPage;
			} else if (next >= lastPage) {
				next = lastPage;
			}
			if (gEnd >= lastPage)
				gEnd = lastPage;
			if (gStart < 1) {
				gStart = 1;
				gEnd = 10;
			}

			if (boardList.size() == 0) {
				out.println("<tr><td colspan='4'>작성된 게시글이 없습니다</td></tr>");
			} else {

				for (int i = 0; i < boardList.size(); i++) {
					BoardItem boardItem = boardList.get(i);
					if ((i + 1) < startList) continue;
					if ((i + 1) > endList) continue;
					out.println("<tr>" + "<td>" + (boardList.size() - i) + "</td>" + "<td><a href='./oneView.jsp?boardId=" + boardId
					+ "&id=" + boardItem.getId() + "&page=" + nowPage + "'>" + boardItem.getTitle() + "</a></td>" + "<td>"
					+ boardItem.getWriter() + "</td>" + "<td>" + boardItem.getDate() + "</td>" + "</tr>");
				}
			}
			%>
		</table>
		<button class="btn" onclick="location.href='./write/write01.jsp?boardId=<%=boardId%>&page=<%=nowPage%>'">글쓰기</button>
		<div id="page-box">
			<% if (nowPage > 1) { %>
			<a href="oneBoard.jsp?boardId=<%=boardId%>&page=1" class="page">&lt;&lt;</a>
			<a href="oneBoard.jsp?boardId=<%=boardId%>&page=<%= previous%>" class="page">&lt;</a>
			<%} %>
					
			<%
			for (int i = gStart; i <= gEnd; i++) {
				if (i == nowPage) {%>
				<a class="page selected"><%= i %></a>
				<%
				} else {%>
			<a href="oneBoard.jsp?boardId=<%=boardId%>&page=<%=i%>" class="page"><%= i %></a>
			<%
				}
			}
			
			if (nowPage < lastPage) { %>
			<a href="oneBoard.jsp?boardId=<%=boardId%>&page=<%=next%>" class="page">&gt;</a>
			<a href="oneBoard.jsp?boardId=<%=boardId%>&page=<%=lastPage%>" class="page">&gt;&gt;</a>
			<% } %>
		</div>
	</div>
</body>
</html>