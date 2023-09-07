<%@page import="board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../include/global_head.jsp" %>
 <body>
 <c:if test="${ param.tname eq 'staff_board' }">
	 <script type="text/javascript">
		$(function() {
			var chk = prompt("직원 전용 게시판입니다. 암호를 입력해주세요.");
			if (chk == "1234") {
				alert("직원 확인되었습니다. 게시판으로 이동합니다.");
			} else {
				alert("암호가 틀렸습니다.");
				location.href = "../main/main.do";
			}
		});
	</script>
 </c:if>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/community/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				
				<%@ include file = "../include/community_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
<!-- 각 테이블마다 다른 배너이미지가 보이게 처리 -->
<c:choose>
	<c:when test="${ param.tname eq 'staff_board' }">
					<img src="../images/community/sub01_title.gif" alt="직원자료실" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;커뮤니티&nbsp;>&nbsp;직원자료실<p>
	</c:when>
	<c:when test="${ param.tname eq 'protector_board' }">
					<img src="../images/community/sub02_title.gif" alt="보호자 게시판" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;커뮤니티&nbsp;>&nbsp;보호자 게시판<p>
	</c:when>
</c:choose>
				</div>
			</div>
			<div class="row text-right" style="margin-bottom:20px; padding-right:50px;">
<!-- 검색부분 -->
<form class="form-inline">	
	<div class="form-group">
		<select name="keyField" class="form-control">
			<option value="title">제목</option>
			<option value="name">작성자</option>
			<option value="content">내용</option>
		</select>
	</div>
	<div class="input-group">
		<input type="text" name="keyString"  class="form-control"/>
		<div class="input-group-btn">
			<button type="submit" class="btn btn-default">
				<i class="glyphicon glyphicon-search"></i>
			</button>
		</div>
	</div>
</form>	
</div>
<div class="row">
	<!-- 게시판리스트부분 -->
	<table class="table table-bordered table-hover">
	<colgroup>
		<col width="80px"/>
		<col width="*"/>
		<col width="120px"/>
		<col width="120px"/>
		<col width="80px"/>
		<col width="50px"/>
	</colgroup>
	
	<thead>
	<tr class="success">
		<th class="text-center">번호</th>
		<th class="text-left">제목</th>
		<th class="text-center">작성자</th>
		<th class="text-center">작성일</th>
		<th class="text-center">조회수</th>
		<th class="text-center">첨부</th>
	</tr>
	</thead>
	
	<tbody>
	<!-- 리스트반복 -->
	<c:forEach items="${ boardLists }" var="row" varStatus="loop">
	<tr>
		<td class="text-center">${ map.totalCount - (((map.pageNum-1)*map.pageSize)+loop.index) }</td>
		<td class="text-left"><a href="../board/view.do?tname=${ param.tname }&num=${ row.num }">${ row.title }</a></td>
		<td class="text-center">${ row.name }</td>
		<td class="text-center">${ row.postdate }</td>
		<td class="text-center">${ row.visitcount }</td>
		<td class="text-center">
		<c:if test="${ not empty row.ofile }">
			O
		</c:if>
		<c:if test="${ empty row.ofile }">
			X
		</c:if>
		</td>
	</tr>
	</c:forEach>
	</tbody>
	</table>
</div>
<div class="row text-right" style="padding-right:50px;">
	<!-- 각종 버튼 부분 -->
	<!-- <button type="reset" class="btn">Reset</button> -->
		
	<button type="button" class="btn btn-default"
		onclick="location.href='../board/write.do?tname=${ param.tname }';" style="margin-left: 18px">글쓰기</button>
				
	<!-- <button type="button" class="btn btn-primary">수정하기</button>
	<button type="button" class="btn btn-success">삭제하기</button>
	<button type="button" class="btn btn-info">답글쓰기</button>
	<button type="button" class="btn btn-warning">리스트보기</button>
	<button type="submit" class="btn btn-danger">전송하기</button> -->
</div>
<div class="row text-center">
	<!-- 페이지번호 부분 -->
	<ul class="pagination justify-content-center">
		<li><span class="glyphicon glyphicon-fast-backward"></span></li>
		<li>${ map.pagingImg }</li>
		<li><span class="glyphicon glyphicon-fast-forward"></span></li>
	</ul>	
</div>

				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>