<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	<form method="post">
		<table border="1px solid black">
			<tr>
				<th colspan="2">게시판 생성</th>
			</tr>
			<tr>
				<th class="category">번호</th>
				<td class="content">신규</td>
			</tr>
			<tr>
				<th class="category">게시판 이름</th>
				<td class="content">
					<input type="text" name="title" class="input-box" id="input-title" placeholder="제목을 입력해주세요" maxlength="50">
				</td>
			</tr>
		</table>
		<button class="btn" id="submit" formaction="./newBoard01.jsp">쓰기</button>
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
		})
	</script>
</body>
</html>