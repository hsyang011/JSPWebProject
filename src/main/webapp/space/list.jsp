<%@page import="utils.BoardPage"%>
<%@page import="board.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../include/global_head.jsp" %>

<%
BoardDAO dao = new BoardDAO();

// 검색어가 있는 경우 클라이언트가 선택한 필드명과 검색어를 저장할 Map컬렉션을 생성한다.
Map<String, Object> param = new HashMap<String, Object>();

/* 검색하면 현재페이지로 폼값이 전송된다. */
String keyField = request.getParameter("keyField");
String keyString = request.getParameter("keyString");
if (keyString != null) {
	param.put("keyField", keyField);
	param.put("keyString", keyString);
}

// 페이지 영역에 저장된 테이블 이름 가져오기
String tname = request.getParameter("tname");
System.out.println("테이블명 가져왔을까요?" + tname);
param.put("tname", tname);

// Map컬렉션을 인수로 게시물의 갯수를 카운트 한다.
int totalCount = dao.selectCount(param);

/*** 페이지 처리 start ***/
int pageSize = Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
int blockPage = Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));
int totalPage = (int)Math.ceil((double)totalCount / pageSize);

int pageNum = 1;
String pageTemp = request.getParameter("pageNum");
if (pageTemp!=null && !pageTemp.equals("")) {
	pageNum = Integer.parseInt(pageTemp);
}

int start = (pageNum - 1)*pageSize + 1;
int end = pageNum*pageSize;
param.put("start", start);
param.put("end", end);
/*** 페이지 처리 end ***/

// 페이지 처리
List<BoardDTO> boardLists = dao.selectListPage(param);

dao.close();

%>

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

<div class="row text-right" style="margin-bottom:20px;
		padding-right:50px;">
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
<%
// 게시물이 있을 때
int virtualNum = 0;
int countNum = 0;
for (BoardDTO dto : boardLists) {
	virtualNum = totalCount - (((pageNum - 1)*pageSize) + countNum++);
%>
	<tr>
		<td class="text-center"><%= virtualNum %></td>
		<td class="text-left"><a href="view.jsp?num=<%= dto.getNum() %>&tname=<%= tname %>"><%= dto.getTitle() %></a></td>
		<td class="text-center"><%= dto.getName() %></td>
		<td class="text-center"><%= dto.getPostdate() %></td>
		<td class="text-center"><%= dto.getVisitcount() %></td>
		<td class="text-center"><%= dto.getOfile()!=null ? "O" : "X" %></td>
	</tr>
<%
}
%>
	</tbody>
	</table>
</div>
<div class="row text-right" style="padding-right:50px;">
	<!-- 각종 버튼 부분 -->
	<!-- <button type="reset" class="btn">Reset</button> -->
		
	<button type="button" class="btn btn-default"
		onclick="location.href='write.jsp?tname=<%= tname %>';" style="margin-left: 18px">글쓰기</button>
				
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
		<li><%= BoardPage.pagingStr(totalCount, pageSize, blockPage, pageNum, (request.getRequestURI()) + "?tname=" + tname) %></li>
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