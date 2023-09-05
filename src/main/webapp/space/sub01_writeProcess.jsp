<%@page import="fileupload.FileUtil"%>
<%@page import="membership.MemberDAO"%>
<%@page import="membership.MemberDTO"%>
<%@page import="space.board.BoardDAO"%>
<%@page import="space.board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/isLoggedIn.jsp" %>
<%
// 1. 파일 업로드 처리
// 업로드 디렉토리의 물리적 경로 확인
String saveDirectory = application.getRealPath("/uploads/");
// 파일 업로드
String originalFileName = "";
try {
	// 업로드가 정상적으로 완료되면 원본파일명을 반환한다.
	originalFileName = FileUtil.uploadFile(request, saveDirectory);
} catch (Exception e) {
	/* 파일 업로드시 오류가 발생되면 경고창을 띄운 후 작성페이지로 이동한다. */
	JSFunction.alertBack("파일 업로드 오류입니다.", out);
	e.printStackTrace();
	return;
}

// 세션영역에서 id값 가져오기
String id = session.getAttribute("UserId").toString();
// 파라미터에서 각 속성값 가져오기
String pass = request.getParameter("pass");
String title = request.getParameter("title");
String content = request.getParameter("content");

// id, pass가 일치하는지 검사한다.
MemberDAO mDao = new MemberDAO();
MemberDTO mDto = mDao.getMemberDTO(id, pass);
mDao.close();

// id, pass가 일치하면 글쓰기를 한다.
if (mDto.getId() != null) {
	BoardDTO bDto = new BoardDTO();
	bDto.setId(id);
	bDto.setTitle(title);
	bDto.setContent(content);
	
	// 첨부파일이 정상적으로 등록되어 원본파일명이 반환되었다면
	if (originalFileName != "") {
		String saveFileName = FileUtil.renameFile(saveDirectory, originalFileName);
		bDto.setOfile(originalFileName);
		bDto.setSfile(saveFileName);
	}
	
	BoardDAO bDao = new BoardDAO();
	int result = bDao.insertWrite(bDto);
	bDao.close();
	
	if (result == 1) {
		JSFunction.alertLocation("글쓰기에 성공하였습니다!", "./sub01.jsp", out);
	} else {
		JSFunction.alertBack("글쓰기에 실패하였습니다.", out);
	}
// 불일치시 비밀번호를 재입력한다.
} else {
	JSFunction.alertBack("비밀번호를 다시 입력하세요.", out);
}
%>