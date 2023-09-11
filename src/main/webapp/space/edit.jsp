<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../include/global_head.jsp" %>
<%@ include file="../include/isLoggedIn.jsp" %>

<%
String num = request.getParameter("num");
String tname = request.getParameter("tname");
BoardDAO dao = new BoardDAO();
// view.jsp와 동일하지만 조회수 증가하는 로직은 추가되면 안된다.
/* dao.updateVisitCount(num); */

// 기존 게시물의 내용을 일거온다.
BoardDTO dto = dao.selectView(num, tname);
// 세션영역에 저장된 회원아이디를 가져와서 문자열로 변환한다.
String sessionId = session.getAttribute("UserId").toString();
// 로그인한 회원이 해당게시물의 작성자인지 확인한다.
if (!sessionId.equals(dto.getId())) {
	// 작성자가 아니라면 진입할 수 없도록 하고 뒤로 이동한다.
	String url = "./list.jsp?tname" + tname;
	JSFunction.alertLocation("작성자 본인만 수정할 수 있습니다.", url, out);
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
<!-- 각 테이블마다 다른 배너이미지가 보이게 처리 -->
<c:choose>
	<c:when test="${ param.tname eq 'notice_board' }">
					<img src="../images/space/sub01_title.gif" alt="공지사항" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;공지사항<p>
	</c:when>
	<c:when test="${ param.tname eq 'calendar_board' }">
					<img src="../images/space/sub02_title.gif" alt="프로그램일정" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;프로그램일정<p>
	</c:when>
	<c:when test="${ param.tname eq 'free_board' }">
					<img src="../images/space/sub03_title.gif" alt="자유게시판" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;자유게시판<p>
	</c:when>
	<c:when test="${ param.tname eq 'photo_board' }">
					<img src="../images/space/sub04_title.gif" alt="사진게시판" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;사진게시판<p>
	</c:when>
	<c:when test="${ param.tname eq 'info_board' }">
					<img src="../images/space/sub05_title.gif" alt="정보자료실" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;정보자료실<p>
	</c:when>
</c:choose>
				</div>
				<div>

<form name="writeFrm" method="post" action="editProcess.jsp" onsubmit="return formValidate(this);" enctype="multipart/form-data">
<input type="hidden" name="num" value="<%= dto.getNum() %>" />
<input type="hidden" name="tname" value="<%= tname %>" />
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
			<input type="password" class="form-control" name="pass" 
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
		onclick="location.href='./list.jsp?tname=<%= tname %>';">리스트보기</button>
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