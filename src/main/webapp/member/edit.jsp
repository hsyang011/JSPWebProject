<%@page import="membership.MemberDAO"%>
<%@page import="membership.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<%
MemberDAO dao = new MemberDAO();
String id = session.getAttribute("UserId").toString();
String pass = session.getAttribute("UserPw").toString();
MemberDTO dto = dao.getMemberDTO(id, pass);

String[] tels = dto.getTel().split("-");
String[] mobiles = dto.getMobile().split("-");
String[] emails = dto.getEmail().split("@");
String mailing = dto.getMailing()!=null ? "Checked" : "";
%>
<script type="text/javascript">
function formValidate(frm) {
	if (frm.name.value == "") {
		alert("이름을 입력해주세요.");
		frm.name.focus();
		return false;
	}
	
	if (frm.id.value == "") {
		alert("아이디를 입력해주세요.");
		frm.id.focus();
		return false;
	}

    //아이디는 8~12자로 입력되었는지 검증
    if(!(4<=frm.id.value.length && frm.id.value.length<=12)){
        alert("아이디는 8~12자 사이만 가능합니다.");
        frm.id.value = "";
        frm.id.focus();
        return false;
    }

    //아이디는 숫자로 시작할 수 없음
    console.log(frm.id.value, frm.id.value[0], 
        frm.id.value.charCodeAt(0));
    if(frm.id.value[0].charCodeAt(0)>=48 &&
            frm.id.value.charCodeAt(0)<=57){
        alert('아이디는 숫자로 시작할 수 없습니다.');
        frm.id.value = '';
        frm.id.focus();
        return false;
    }

    //아이디는 영문+숫자의 조합으로만 사용할 수 있다. 
    /* 아이디를 구성하는 각 문자가 소문자 a~z, 대문자 A~Z, 숫자 0~9
    사이가 아니라면 잘못된 문자가 포함된 경우이므로 전송을 중단한다.*/
    for(var i=0 ; i<frm.id.value.length ; i++){
        if(!((frm.id.value[i]>='a' && frm.id.value[i]<='z') ||
            (frm.id.value[i]>='A' && frm.id.value[i]<='Z') ||
            (frm.id.value[i]>='0' && frm.id.value[i]<='9'))){
            alert("아이디는 영문 및 숫자의 조합만 가능합니다.");
            frm.id.value='';
            frm.id.focus();
            return false; 
        }
    }


    //패스워드 입력 확인
    if(frm.pass.value==''){
        alert("패스워드를 입력해주세요.");
        frm.pass.focus();
        return false;
    }
    if(frm.pass2.value==''){
        alert("패스워드 확인을 입력해주세요.");
        frm.pass2.focus();
        return false;
    }
    //만약 입력한 패스워드가 일치하지 않는다면..
    if(frm.pass.value!=frm.pass2.value){
        alert('패스워드가 일치하지 않습니다. 다시 입력해주세요.');
        //사용자가 입력한 패스워드를 지운다. 
        frm.pass.value = '';
        frm.pass2.value = '';
        //입력상자로 포커싱 한다. 
        frm.pass.focus();
        return false;
    }
    // 휴대폰 검사
    if (frm.mobile1.value=="" || frm.mobile2.value=="" || frm.mobile3.value=="") {
    	alert("휴대폰 번호를 입력해주세요.");
    	frm.mobile1.value == "";
    	frm.mobile2.value == "";
    	frm.mobile3.value == "";
    	frm.mobile1.focus();
    	return false;
    }
    // 이메일 검사
    if (frm.email_1.value=="" || frm.email_2.value=="") {
    	alert("이메일을 입력해주세요.");
    	frm.email_1.value == "";
    	frm.email_2.value == "";
    	frm.email_1.focus();
    	return false;
    }
    // 주소 검사
    if (frm.zipcode.value=="" || frm.addr1.value=="" || frm.addr2.value=="") {
    	alert("주소를 입력해주세요.");
    	frm.zipcode.value == "";
    	frm.addr1.value == "";
    	frm.addr2.value == "";
    	frm.zipcode.focus();
    	return false;
    }
}

/* 아이디 중복확인 */
function id_check_person() {
	
}

/* 이메일 도메인 선택 */
function email_input(domain) {
	var choiceDomain = domain.value;
	
	document.joinForm.email_2.value = choiceDomain;
}

/* 포커스 자동 이동 로직 */
function focusMove(thisObj, nextName, inputLen) {
	var strLen = thisObj.value.length;
	
	if (strLen >= inputLen) {
		eval("document.joinForm." + nextName).focus();
	}
}

/* 우편번호 검색 클릭시 팝업창 오픈 */
/* function zipFind(popupName, popupLink, width, height, pos) {
	window.open(popupLink, popupName, "width="+width+", height="+height+", left="+pos+", top="+pos+"\"");
} */
</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	function postOpen() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	        	var frm = document.joinForm;
	        	frm.zipcode.value = data.zonecode;
	        	frm.addr1.value = data.address;
	        	frm.addr2.focus();
	        }
	    }).open();
	}
</script>

 <body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/member/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/member_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/join_tit.gif" alt="회원가입" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;회원가입<p>
				</div>

				<p class="join_title"><img src="../images/join_tit03.gif" alt="회원정보입력" /></p>
				
				<!-- 회원가입 폼 -->
				<form action="./editAction.jsp" name="joinForm" onsubmit="return formValidate(this);">
				<table cellpadding="0" cellspacing="0" border="0" class="join_box">
					<colgroup>
						<col width="80px;" />
						<col width="*" />
					</colgroup>
					<tr>
						<th><img src="../images/join_tit001.gif" /></th>
						<td><input type="text" name="name" value="<%= dto.getName() %>" readonly class="join_input" /></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit002.gif" /></th>
						<td><input type="text" name="id"  value="<%= dto.getId() %>" readonly class="join_input" />&nbsp;<a onclick="id_check_person();" style="cursor:hand;"><img src="../images/btn_idcheck.gif" alt="중복확인"/></a>&nbsp;&nbsp;<span>* 4자 이상 12자 이내의 영문/숫자 조합하여 공백 없이 기입</span></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit003.gif" /></th>
						<td><input type="password" name="pass" value="" class="join_input" />&nbsp;&nbsp;<span>* 4자 이상 12자 이내의 영문/숫자 조합</span></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit04.gif" /></th>
						<td><input type="password" name="pass2" value="" class="join_input" /></td>
					</tr>
					

					<tr>
						<th><img src="../images/join_tit06.gif" /></th>
						<td>
							<input type="text" name="tel1" value="<%= tels[0] %>" maxlength="3" class="join_input" style="width:50px;" onkeyup="focusMove(this, 'tel2', 3);" />&nbsp;-&nbsp;
							<input type="text" name="tel2" value="<%= tels[1] %>" maxlength="4" class="join_input" style="width:50px;" onkeyup="focusMove(this, 'tel3', 4);" />&nbsp;-&nbsp;
							<input type="text" name="tel3" value="<%= tels[2] %>" maxlength="4" class="join_input" style="width:50px;" onkeyup="focusMove(this, 'mobile1', 4);" />
						</td>
					</tr>
					<tr>
						<th><img src="../images/join_tit07.gif" /></th>
						<td>
							<input type="text" name="mobile1" value="<%= mobiles[0] %>" maxlength="3" class="join_input" style="width:50px;" onkeyup="focusMove(this, 'mobile2', 3);" />&nbsp;-&nbsp;
							<input type="text" name="mobile2" value="<%= mobiles[1] %>" maxlength="4" class="join_input" style="width:50px;" onkeyup="focusMove(this, 'mobile3', 4);" />&nbsp;-&nbsp;
							<input type="text" name="mobile3" value="<%= mobiles[2] %>" maxlength="4" class="join_input" style="width:50px;" onkeyup="focusMove(this, 'email_1', 4);" /></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit08.gif" /></th>
						<td>
 
	<input type="text" name="email_1" style="width:100px;height:20px;border:solid 1px #dadada;" value="<%= emails[0] %>" /> @ 
	<input type="text" name="email_2" style="width:150px;height:20px;border:solid 1px #dadada;" value="<%= emails[1] %>" readonly />
	<select name="last_email_check2" onChange="email_input(this);" class="pass" id="last_email_check2" >
		<option selected="" value="">선택해주세요</option>
		<option value="1" >직접입력</option>
		<option value="dreamwiz.com" >dreamwiz.com</option>
		<option value="empal.com" >empal.com</option>
		<option value="empas.com" >empas.com</option>
		<option value="freechal.com" >freechal.com</option>
		<option value="hanafos.com" >hanafos.com</option>
		<option value="hanmail.net" >hanmail.net</option>
		<option value="hotmail.com" >hotmail.com</option>
		<option value="intizen.com" >intizen.com</option>
		<option value="korea.com" >korea.com</option>
		<option value="kornet.net" >kornet.net</option>
		<option value="msn.co.kr" >msn.co.kr</option>
		<option value="nate.com" >nate.com</option>
		<option value="naver.com" >naver.com</option>
		<option value="netian.com" >netian.com</option>
		<option value="orgio.co.kr" >orgio.co.kr</option>
		<option value="paran.com" >paran.com</option>
		<option value="sayclub.com" >sayclub.com</option>
		<option value="yahoo.co.kr" >yahoo.co.kr</option>
		<option value="yahoo.com" >yahoo.com</option>
		<option value="gmail.com" >gmail.com</option>
	</select>
	 
						<input type="checkbox" name="mailing" <%= mailing %> value="1">
						<span>이메일 수신동의</span></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit09.gif" /></th>
						<td>
						<input type="text" name="zipcode" value="<%= dto.getZipcode() %>"  class="join_input" style="width:50px;" />&nbsp;&nbsp;
						<!--
						<a href="javascript:;" title="새 창으로 열림" onclick="zipFind('zipFind', '<?=$_Common[bbs_path]?>member_zipcode_find.php', 590, 500, 0);" onkeypress="">[우편번호검색]</a>
						 -->
						<a href="javascript:;" title="새 창으로 열림" onclick="postOpen()" onkeypress="">[우편번호검색]</a>
						<br/>
						
						<input type="text" name="addr1" value="<%= dto.getAddr1() %>"  class="join_input" style="width:550px; margin-top:5px;" /><br>
						<input type="text" name="addr2" value="<%= dto.getAddr2() %>"  class="join_input" style="width:550px; margin-top:5px;" />
						
						</td>
					</tr>
				</table>

				<p style="text-align:center; margin-bottom:20px"><input type="image" src="../images/btn01.gif" />&nbsp;&nbsp;<a href="./join01.jsp"><img src="../images/btn02.gif" /></a></p>
				</form>
				
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
