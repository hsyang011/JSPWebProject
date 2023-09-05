<%@page import="space.board.BoardDTO"%>
<%@page import="space.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>

<%
String num = request.getParameter("num");
BoardDAO dao = new BoardDAO();
dao.updateVisitCount(num);

BoardDTO dto = dao.selectView(num);
dao.close();
%>
<script type="text/javascript">
function deletePost() {
	var comfirmed = confirm("정말로 삭제하겠습니까?");
	if (comfirmed){
		document.boardFrm.submit();
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

<form enctype="multipart/form-data" method="post" action="deleteProcess.jsp" name="boardFrm">
<input type="hidden" name="num" value="<%= num %>" />
<table class="table table-bordered">
<colgroup>
	<col width="20%"/>
	<col width="30%"/>
	<col width="20%"/>
	<col width="*"/>
</colgroup>
<tbody>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">작성자</th>
		<td>
			<%= dto.getName() %>
		</td>
		<th class="text-center" 
			style="vertical-align:middle;">작성일</th>
		<td>
			<%= dto.getPostdate() %>
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">이메일</th>
		<td>
			<%= dto.getEmail() %>
		</td>
		<th class="text-center" 
			style="vertical-align:middle;">조회수</th>
		<td>
			<%= dto.getVisitcount() %>
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">제목</th>
		<td colspan="3">
			<%= dto.getTitle() %>
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">내용</th>
		<td colspan="3">
			<%= dto.getContent() %>
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">첨부파일</th>
		<td colspan="3">
			<%= dto.getOfile() %>
		</td>
	</tr>
</tbody>
</table>

<div class="row text-center" style="">
	<!-- 각종 버튼 부분 -->
	<button type="button" class="btn btn-primary">수정하기</button>
	<button type="button" class="btn btn-success" onclick="deletePost();">삭제하기</button>	
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