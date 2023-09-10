<%@page import="market.ProductsDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<%@ include file="../include/isLoggedIn.jsp" %>
<%
ProductsDTO dto = (ProductsDTO)request.getAttribute("dto");
String price = dto.getProduct_price().replace(",", "").replace(" ", "");
int reward = Integer.parseInt(price) / 100;
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
				<div class="market_view_box">
				
					<!-- 구매하기, 장바구니 전송 폼 -->
					<form method="post" action="../market/basket.do" name="viewFrm">
					<input type="hidden" name="num" value="<%= dto.getNum() %>" />
					<input type="hidden" name="chk" value="1" />
					<div class="market_left">
						<img src="<%= dto.getProduct_image() %>" width="400" />
						<p class="plus_btn"><a href=""><img src="../images/market/plus_btn.gif" /></a></p>
					</div>
					<div class="market_right">
						<p class="m_title"><%= dto.getProduct_name() %>
						<p>- <%= dto.getProduct_name() %></p>
						<ul class="m_list">
							<li>
								<dl>
									<dt>가격</dt>
									<dd class="p_style"><%= dto.getProduct_price() %></dd>
								</dl>
								<dl>
									<dt>적립금</dt>
									<dd><%= reward %></dd>
								</dl>
								<dl>
									<dt>수량</dt>
									<dd><input type="text" name="count" value="1" class="n_box" /></dd>
								</dl>
								<dl style="border-bottom:0px;">
									<dt>주문정보</dt>
									<dd><input type="text" name="orderName" class="n_box" style="width:200px;" /></dd>
								</dl>
								<div style="clear:both;"></div>
							</li>
						</ul>
						<p class="btn_box"><a href="../market/basketOrder.do"><img src="../images/market/m_btn01.gif" alt="바로구매" /></a>&nbsp;&nbsp;<input type="image" src="../images/market/m_btn02.gif" alt="장바구니" /></p>
					</div>
					</form>
				</div>
				<img src="../images/market/cake_img.JPG" />

			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
