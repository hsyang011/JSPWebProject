<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../include/global_head.jsp" %>

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

		<img src="../images/community/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				
				<%@ include file = "../include/community_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/community/sub02_title.gif" alt="보호자 게시판" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;커뮤니티&nbsp;>&nbsp;보호자 게시판<p>
				</div>
			<div>

<form enctype="multipart/form-data" method="post" action="../board/delete.do" name="boardFrm">
<input type="hidden" name="num" value="${ dto.num }" />
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
			${ dto.name }
		</td>
		<th class="text-center" 
			style="vertical-align:middle;">작성일</th>
		<td>
			${ dto.postdate }
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">이메일</th>
		<td>
			${ dto.email }
		</td>
		<th class="text-center" 
			style="vertical-align:middle;">조회수</th>
		<td>
			${ dto.visitcount }
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">제목</th>
		<td colspan="3">
			${ dto.title }
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">내용</th>
		<td colspan="3">
			${ dto.content }
			<c:if test="${ not empty dto.ofile and isImage eq true }">
				<br /><img src="../uploads/${ dto.sfile }" style="max-width: 100%" alt="이미지" />
			</c:if>
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">첨부파일</th>
		<td colspan="3">
			<c:if test="${ not empty dto.ofile }">
			${ dto.ofile }
			<a href="../board/download.do?ofile=${ dto.ofile }&sfile=${ dto.sfile }&num=${ dto.num }">
				[다운로드]
			</a>
			</c:if>
		</td>
	</tr>
</tbody>
</table>

<div class="row text-center" style="">
	<!-- 각종 버튼 부분 -->
	<!-- 로그인이 된 상태에서 게시물 작성자와 로그인 정보가 일치하면 수정, 삭제하기 버튼이 보이게 처리한다. -->
	<c:if test="${ not empty UserId and UserId eq dto.id }">
	<button type="button" class="btn btn-primary" onclick="location.href='../board/edit.do?num=${ dto.num }'">수정하기</button>
	<button type="button" class="btn btn-success" onclick="deletePost();">삭제하기</button>
	</c:if>
	<button type="button" class="btn btn-warning" 
		onclick="location.href='../board/list.do';">리스트보기</button>
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