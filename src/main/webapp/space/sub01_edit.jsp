<%@page import="space.board.BoardDTO"%>
<%@page import="space.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<%@ include file="../include/isLoggedIn.jsp" %>

<%
String num = request.getParameter("num");
BoardDAO dao = new BoardDAO();
// view.jsp와 동일하지만 조회수 증가하는 로직은 추가되면 안된다.
/* dao.updateVisitCount(num); */

// 기존 게시물의 내용을 일거온다.
BoardDTO dto = dao.selectView(num);
// 세션영역에 저장된 회원아이디를 가져와서 문자열로 변환한다.
String sessionId = session.getAttribute("UserId").toString();
// 로그인한 회원이 해당게시물의 작성자인지 확인한다.
if (!sessionId.equals(dto.getId())) {
	// 작성자가 아니라면 진입할 수 없도록 하고 뒤로 이동한다.
	JSFunction.alertLocation("작성자 본인만 수정할 수 있습니다.", "./sub01_list.jsp", out);
	return;
}
dao.close();
%>
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
					<img src="../images/space/sub01_title.gif" alt="공지사항" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;공지사항<p>
				</div>
				<div>

<form name="writeFrm" method="post" action="sub01_editProcess.jsp" onsubmit="return formValidate(this);" enctype="multipart/form-data">
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
		onclick="location.href='./sub01.jsp';">리스트보기</button>
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