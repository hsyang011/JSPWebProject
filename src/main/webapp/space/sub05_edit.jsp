<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<%@ include file="../include/isLoggedIn.jsp" %>

<%@ include file="./common_edit.jsp" %>
<script type="text/javascript">
// 폼 내용 검증
function formValidate(frm) {
	if (frm.pass.value == "") {
		alert("비밀번호를 입력하세요.");
		frm.pass.focus();
		return false;
	}
	if (frm.title.value == "") {
		alert("제목을 입력하세요.");
		frm.title.focus();
		return false;
	}
	if (frm.content.value == "") {
		alert("내용을 입력하세요.");
		frm.content.focus();
		return false;
	}
}
</script>
 <body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/space/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				
				<%@ include file = "../include/space_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/space/sub05_title.gif" alt="정보자료실" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;정보자료실<p>
				</div>
			<div>

<form name="writeFrm" method="post" action="common_editProcess.jsp" onsubmit="return formValidate(this);" enctype="multipart/form-data">
<input type="hidden" name="num" value="<%= dto.getNum() %>" />
<input type="hidden" name="prevOfile" value="<%= dto.getOfile() %>" />
<input type="hidden" name="prevSfile" value="<%= dto.getSfile() %>" />
<table class="table table-bordered">
<colgroup>
	<col width="20%"/>
	<col width="*"/>
</colgroup>
<tbody>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">작성자</th>
		<td>
			<input type="text" class="form-control"  name="name" value="<%= dto.getName() %>"
				style="width:100px;" readonly />
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">이메일</th>
		<td>
			<input type="text" class="form-control" name="email" value="<%= dto.getEmail() %>"
				style="width:400px;" readonly />
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">패스워드</th>
		<td>
			<input type="text" class="form-control" name="pass" 
				style="width:200px;" />
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">제목</th>
		<td>
			<input type="text" class="form-control" name="title" value="<%= dto.getTitle() %>" />
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">내용</th>
		<td>
			<textarea rows="10" class="form-control" name="content"><%= dto.getContent() %></textarea>
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">첨부파일</th>
		<td>
			<input type="file" class="form-control" name="ofile" />
		</td>
	</tr>
</tbody>
</table>

<div class="row text-center" style="">
	<!-- 각종 버튼 부분 -->
	
	<button type="submit" class="btn btn-danger">전송하기</button>
	<button type="reset" class="btn">Reset</button>
	<button type="button" class="btn btn-warning" 
		onclick="location.href='./sub05.jsp';">리스트보기</button>
</div>
</form> 

				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>


	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>