<%@page import="membership.MemberDTO"%>
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
MemberDTO mdto = (MemberDTO)request.getAttribute("dto");
String[] mobiles = mdto.getMobile().split("-");
String[] emails = mdto.getEmail().split("@");
int totalPrice = 0;
%>
<script type="text/javascript">
$(function() {
	document.secondFrm.name.value = document.firstFrm.name.value;
	document.secondFrm.zipcode.value = document.firstFrm.zipcode.value;
	document.secondFrm.addr1.value = document.firstFrm.addr1.value;
	document.secondFrm.addr2.value = document.firstFrm.addr2.value;
	document.secondFrm.mobile1.value = document.firstFrm.mobile1.value;
	document.secondFrm.mobile2.value = document.firstFrm.mobile2.value;
	document.secondFrm.mobile3.value = document.firstFrm.mobile3.value;
	document.secondFrm.email1.value = document.firstFrm.email1.value;
	document.secondFrm.email2.value = document.firstFrm.email2.value;
	
	$(".chk").change(function(e) {
		if ($(e.target).val() == 1) {
			document.secondFrm.name.value = document.firstFrm.name.value;
			document.secondFrm.zipcode.value = document.firstFrm.zipcode.value;
			document.secondFrm.addr1.value = document.firstFrm.addr1.value;
			document.secondFrm.addr2.value = document.firstFrm.addr2.value;
			document.secondFrm.mobile1.value = document.firstFrm.mobile1.value;
			document.secondFrm.mobile2.value = document.firstFrm.mobile2.value;
			document.secondFrm.mobile3.value = document.firstFrm.mobile3.value;
			document.secondFrm.email1.value = document.firstFrm.email1.value;
			document.secondFrm.email2.value = document.firstFrm.email2.value;
		} else {
			document.secondFrm.name.value = "";
			document.secondFrm.zipcode.value = "";
			document.secondFrm.addr1.value = "";
			document.secondFrm.addr2.value = "";
			document.secondFrm.mobile1.value = "";
			document.secondFrm.mobile2.value = "";
			document.secondFrm.mobile3.value = "";
			document.secondFrm.email1.value = "";
			document.secondFrm.email2.value = "";
		}
	});
});
</script>

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
				<p class="con_tit"><img src="../images/market/basket_title01.gif" /></p>
				<table cellpadding="0" cellspacing="0" border="0" class="basket_list" style="margin-bottom:50px;">
					<colgroup>
						<col width="7%" />
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
							<th>선택</th>
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
<%
for (BasketDTO dto : basketInfo) {
%>
						<tr>
							<td><input type="checkbox" name="chk" value="1" /></td>
							<td><img src="../images/market/cake_img1.jpg" /></td>
							<td><%= new ProductsDAO().getProductInfo(dto.getNum()).getProduct_name() %></td>
							<td><%= new ProductsDAO().getProductInfo(dto.getNum()).getProduct_price() %>원</td>
							<td><img src="../images/market/j_icon.gif" />&nbsp;<%= (Integer.parseInt(new ProductsDAO().getProductInfo(dto.getNum()).getProduct_price().replace(",","").replace(" ","")) / 100) * Integer.parseInt(dto.getSelected_quantity()) %>원</td>
							<td><input type="text" name="" value="2" class="basket_num" />&nbsp;<a href=""><img src="../images/market/m_btn.gif" /></a></td>
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

				<p class="con_tit"><img src="../images/market/basket_title02.gif" /></p>
				
				<!-- 1번째 폼 -->
				<form name="firstFrm">
				<table cellpadding="0" cellspacing="0" border="0" class="con_table" style="width:100%;" style="margin-bottom:50px;">
					<colgroup>
						<col width="15%" />
						<col width="*" />
					</colgroup>
					
					<tbody>
						<tr>
							<th>성명</th>
							<td style="text-align:left;"><input type="text" name="name"  value="<%= mdto.getName() %>" class="join_input" /></td>
						</tr>
						<tr>
							<th>주소</th>
							<td style="text-align:left;"><input type="text" name="zipcode"  value="<%= mdto.getZipcode() %>" class="join_input" style="width:50px; margin-bottom:5px;" /><a href=""><img src="../images/market/basket_btn03.gif" style="margin-bottom:5px;" /></a><br /><input type="text" name="addr1"  value="<%= mdto.getAddr1() %>" class="join_input" style="width:300px; margin-bottom:5px;" /> 기본주소<br /><input type="text" name="addr2"  value="<%= mdto.getAddr2() %>" class="join_input" style="width:300px;" /> 나머지주소</td>
						</tr>
						<tr>
							<th>휴대폰</th>
							<td style="text-align:left;"><input type="text" name="mobile1"  value="<%= mobiles[0] %>" class="join_input" style="width:50px;" /> - <input type="text" name="mobile2"  value="<%= mobiles[1] %>" class="join_input" style="width:50px;" /> - <input type="text" name="mobile3"  value="<%= mobiles[2] %>" class="join_input" style="width:50px;" /></td>
						</tr>
						<tr>
							<th>이메일주소</th>
							<td style="text-align:left;"><input type="text" name="email1"  value="<%= emails[0] %>" class="join_input" style="width:100px;" /> @ <input type="text" name="email2"  value="<%= emails[1] %>" class="join_input" style="width:100px;" /></td>
						</tr>
					</tbody>
				</table>
				</form>

				
				<!-- 2번째 폼 -->
				<form method="post" action="../market/paymentProcess.do?paymentAmount=<%= totalPrice %>" name="secondFrm">
				<p class="con_tit"><img src="../images/market/basket_title03.gif" /></p>
				<p style="text-align:right">배송지 정보가 주문자 정보와 동일합니까? 예<input type="radio" name="chk" class="chk" value="1" checked /> 아니오<input type="radio" name="chk" class="chk" /></p>
				<table cellpadding="0" cellspacing="0" border="0" class="con_table" style="width:100%;" style="margin-bottom:50px;">
					<colgroup>
						<col width="15%" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th>성명</th>
							<td style="text-align:left;"><input type="text" name="name"  value="" class="join_input" /></td>
						</tr>
						<tr>
							<th>주소</th>
							<td style="text-align:left;"><input type="text" name="zipcode"  value="" class="join_input" style="width:50px; margin-bottom:5px;" /><a href=""><img src="../images/market/basket_btn03.gif" style="margin-bottom:5px;" /></a><br /><input type="text" name="addr1"  value="" class="join_input" style="width:300px; margin-bottom:5px;" /> 기본주소<br /><input type="text" name="addr2"  value="" class="join_input" style="width:300px;" /> 나머지주소</td>
						</tr>
						<tr>
							<th>휴대폰</th>
							<td style="text-align:left;"><input type="text" name="mobile1"  value="" class="join_input" style="width:50px;" /> - <input type="text" name="mobile2"  value="" class="join_input" style="width:50px;" /> - <input type="text" name="mobile3"  value="" class="join_input" style="width:50px;" /></td>
						</tr>
						<tr>
							<th>이메일주소</th>
							<td style="text-align:left;"><input type="text" name="email1"  value="" class="join_input" style="width:100px;" /> @ <input type="text" name="email2"  value="" class="join_input" style="width:100px;" /></td>
						</tr>
						<tr>
							<th>배송메세지</th>
							<td style="text-align:left;"><input type="text" name="message"  value="" class="join_input" style="width:500px;" /></td>
						</tr>
					</tbody>
					</form>
					
				</table>

				<p class="con_tit"><img src="../images/market/basket_title04.gif" /></p>
				<table cellpadding="0" cellspacing="0" border="0" class="con_table" style="width:100%;" style="margin-bottom:30px;">
					<colgroup>
						<col width="15%" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th>결제금액</th>
							<td style="text-align:left;"><span class="money"><%= totalPrice %>원</span></td>
						</tr>
						<tr>
							<th>결제방식선택</th>
							<td style="text-align:left;"><input type="radio" name="paymentType" value="card" checked /> 카드결제&nbsp;&nbsp;&nbsp;<input type="radio" name="paymentType" value="nonePassbook" /> 무통장입금&nbsp;&nbsp;&nbsp;<input type="radio" name="paymentType" value="moneyTransfer" /> 실시간 계좌이체</td>
						</tr>
					</tbody>
				</table>
				<p style="text-align:right;"><input type="image" src="../images/market/basket_btn04.gif" /></p>
				</form>
				
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
