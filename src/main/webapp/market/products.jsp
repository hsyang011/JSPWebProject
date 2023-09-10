<%@page import="java.util.ArrayList"%>
<%@page import="market.ProductsDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<%
List<ProductsDTO> products = (ArrayList<ProductsDTO>)request.getAttribute("products");
boolean isLogin = session.getAttribute("UserId") != null;
%>

 <body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/market/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				
				<%@ include file = "../include/market_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/market/sub01_title.gif" alt="수아밀 제품 주문" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린장터&nbsp;>&nbsp;수아밀 제품 주문<p>
				</div>
				<table cellpadding="0" cellspacing="0" border="0" class="market_board01">
					<colgroup>
						<col width="5%" />
						<col width="20%" />
						<col width="*" />
						<col width="10%" />
						<col width="10%" />
						<col width="15%" />
					</colgroup>
					<tr>
						<th>선택</th>
						<th>상품이미지</th>
						<th>상품명</th>
						<th>가격</th>
						<th>수량</th>
						<th>구매</th>
					</tr>
<%
for (ProductsDTO dto : products) {
%>
					<tr>
						<form method="post" action="../market/basket.do">
						<input type="hidden" name="num" value="<%= dto.getNum() %>" />
						<td><input type="checkbox" name="chk" value="1" /></td>
						<td><a href="../market/market_view.do?num=<%= dto.getNum() %>"><img src="<%= dto.getProduct_image() %>" /></a></td>
						<td class="t_left"><a href="../market/market_view.do?num=<%= dto.getNum() %>"><%= dto.getProduct_name() %></a></td>
						<td class="p_style"><%= dto.getProduct_price() %></td>
						<td><input type="text" name="count" value="1" class="n_box" /></td>
<%
if (isLogin) {
%>
						<td><input type="image" src="../images/market/btn01.gif" style="margin-bottom:5px;" /></a><br /><input type="image" src="../images/market/btn02.gif" /></td>
<%
}
%>
						</form>
					</tr>
<%
}
%>
				</table>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
