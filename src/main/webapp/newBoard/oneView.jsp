<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.ac.kopo.kopo08.domain.Board, kr.ac.kopo.kopo08.domain.BoardItem, java.util.List, 
kr.ac.kopo.kopo08.service.BoardItemService, kr.ac.kopo.kopo08.service.BoardItemServiceImpl"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 보기</title>
<link rel="stylesheet" type="text/css" href="board.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style>
	body {
		display: flex;
		justify-content: center;
		text-align: center;
	}
	
	#content-wrap {
		display: flex;
		flex-direction: column;
		justify-content: center;
		items-align: center;
	}
	
	#title {
		width: 500px;
	}
	
	#main-table {
		width: 850px;
		border-collapse: collapse;
		border-top: 2px solid black;
		border-bottom: 2px solid black;
	}
	
	.category {
		border-right: 1px solid black;
		width: 150px;
	}
	
	.content {
		text-align: left;
		padding:8px;
	}
	
	#main-table tr {
		border-bottom: 1px solid black;
	}
	
	#boardId:focus {
		outline: none;
	}
	
	#comment-box {
		padding:20px 0px;
		display: flex;
		width:  850px;
		flex-direction: column;
		justify-content: space-between;
		flex-direction: row;
	}
	
	#comment-table {
		width: 850px;
		border-collapse: collapse;
		/* border: 1px solid black; */
		border-bottom: 2px solid black;
		border-top: 2px solid black;
	}
	
	.view-comment {
		border-top: 1px solid black;
	}
	
	.view-comment th {
		padding: 10px;
	}
	
	.view-comment td {
		text-align: left;
		padding:8px;
	}
	
	.comment-date {
		font-size: 11px;
		color: gray;
	}
	
	#comment {
		width: 600px;
		height: 100px;
		resize: none;
		border-radius: 5px;
	}
	
	.comment-title	{
		width: 100px;
	}
	
	.commentBtn {
		cursor: pointer;
		width: 100px;
		height: 135px;
		margin: 0px 10px;
		padding: 0;
		border-radius: 5px;
		border: 1px solid black;
	}
</style>
</head>
<body>
<%
	String boardId = "";
	String title = "";
	String writer = "";
	String strDate = "";
	String content = "";
	
	request.setCharacterEncoding("UTF-8");
	boardId = request.getParameter("boardId");
	String nowPage = request.getParameter("page");
	int id = Integer.parseInt(request.getParameter("id"));
	
	BoardItemService bItemService = BoardItemServiceImpl.getInstance();
	BoardItem boardItem = bItemService.selectOne(id);
	title = boardItem.getTitle();
	writer = boardItem.getWriter();
	strDate = boardItem.getDate();
	content = boardItem.getContent();
	content = content.replaceAll("\n", "<br>");
%>
<body>
	<div id="content-wrap">
		<form method="post">
			<table id="main-table">
				<tr>
					<th colspan="2">게 시 글</th>
				</tr>
				<tr>
					<th class="category">번호</th>
					<td class="content">
						<input type="text" name="boardId" id="boardId" value="<%=id%>" 
						style="border:none; font-size: 15px;" readonly>
					</td>
				</tr>
				<tr>
					<th class="category">제목</th>
					<td class="content">
						<%=title%>
					</td>
				</tr>
				<tr>
					<th class="category">작성자</th>
					<td class="content">
						<%=writer%>
					</td>
				</tr>
				<tr>
					<th class="category">일자</th>
					<td class="content">
						<%=strDate%>
					</td>
				</tr>
		
				<tr>
					<th class="category">내용</th>
					<td class="content">
						<%=content%>
					</td>
				</tr>
			</table>
			<button class="btn" id="back"><a href="./oneBoard.jsp?boardId=<%=boardId%>&page=<%=nowPage%>">목록으로</a></button>
			<button class="btn" id="update" formaction="./update/update01.jsp?boardId=<%=boardId%>&id=<%=id%>&page=<%=nowPage%>">수정</button>
		</form>
		<div id="comment-box">
			<form method="post">
				<table id="comment-table">
						<tr>
							<th rowspan="2" class="comment-title">댓글</th>
							<td style="text-align: left; padding: 5px 15px;">
								<span>작성자</span>
								<input type="text" name="writer" id="writer" placeholder="작성자">
							</td>
							<td  rowspan="2">
								<button class="commentBtn" id="input-comment" formaction="./write/write02.jsp?boardId=<%=boardId%>&id=<%=id%>">작성</button>
							</td>
						</tr>
						<tr>
							<td>
								<textarea name="content" id="comment" placeholder="내용을 입력해주세요"></textarea>
							</td>
						</tr>	
					<%
					List<BoardItem> comments = boardItem.getComments();
					if (comments.size() != 0) {
						for (int i = 0; i < comments.size(); i++) {
							BoardItem comment = comments.get(i);
							out.println("<tr class='view-comment'>" +
											"<th>" + 
												comment.getWriter() + "<br>" +
												"<span class='comment-date'>(" + comment.getDate() + ")</span>" +
											"</th>" +
											"<td>" + comment.getContent().replaceAll("\n", "<br>") + "</td>" +
										"</tr>");
						}
					}
					%>
				</table>
			</form>
		</div>
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
			$('#input-comment').click(function() {
				var writer = $('#writer').val();
				var comment = $('#comment').val();
				
				if ($.trim(writer) == "") {
					alert('작성자를 입력해주세요');
					return false;
				}
				
				if(!filter(writer)) {
					alert('작성자 명은 공백 없이 한글, 숫자, 영문 2자리 이상 작성해주세요');
					return false;
				}
				
				if ($.trim(comment) == "") {
					alert('내용을 입력해주세요');
					return false;
				}
				
				if ($.trim(comment) != "" && $.trim(writer) != "" && filter(writer)) {
					return true;
				}
			});
		});
	</script>
</body>
</html>