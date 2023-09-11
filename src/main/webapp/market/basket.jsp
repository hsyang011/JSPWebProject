<%@page import="market.ProductsDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="market.BasketDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<%@ include file="../include/isLoggedIn.jsp" %>
<%
List<BasketDTO> basketInfo = (ArrayList<BasketDTO>)request.getAttribute("basketInfo");
int totalPrice = 0;
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
				<table cellpadding="0" cellspacing="0" border="0" class="basket_list">
					<colgroup>
						<!-- <col width="7%" /> -->
						<col width="10%" />
						<col width="*" />
						<col width="10%" />
						<col width="8%" />
						<col width="10%" />
						<col width="10%" />
						<col width="10%" />
						<col width="8%" />
					</colgroup>
					<thead>
						<tr>
							<!-- <th>선택</th> -->
							<th>이미지</th>
							<th>상품명</th>
							<th>판매가</th>
							<th>적립금</th>
							<th>수량</th>
							<th>배송구분</th>
							<th>배송비</th>
							<th>합계</th>
						</tr>
					</thead>
					<tbody>
<!-- 품목 반복 -->
<%
for (BasketDTO dto : basketInfo) {
%>
						<tr>
							<!-- <td><input type="checkbox" name="chk" value="1" /></td> -->
							<td><img src="../images/market/cake_img1.jpg" /></td>
							<td><%= new ProductsDAO().getProductInfo(dto.getNum()).getProduct_name() %></td>
							<td><%= new ProductsDAO().getProductInfo(dto.getNum()).getProduct_price() %>원</td>
							<td><img src="../images/market/j_icon.gif" />&nbsp;<%= (Integer.parseInt(new ProductsDAO().getProductInfo(dto.getNum()).getProduct_price().replace(",","").replace(" ","")) / 100) * Integer.parseInt(dto.getSelected_quantity()) %>원</td>
							<td><input type="text" name="" value="<%= dto.getSelected_quantity() %>" readonly class="basket_num" />&nbsp;<a href=""><!-- <img src="../images/market/m_btn.gif" /> --></a></td>
							<td>무료배송</td>
							<td>[조건]</td>
							<td><span><%= dto.getTotal_price() %>원<span></td>
							<% totalPrice += Integer.parseInt(dto.getTotal_price()); %>
						</tr>
<%
}
%>
					</tbody>
				</table>
				<p class="basket_text">[ 기본 배송 ] <span>상품구매금액</span> <%= totalPrice %> + <span>배송비</span> 0 = 합계 : <span class="money"><%= totalPrice %>원</span><br /><br /><a href="../market/products.do"><img src="../images/market/basket_btn01.gif" /></a>&nbsp;<a href="../market/basketOrder.do"><img src="../images/market/basket_btn02.gif" /></a></p>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
