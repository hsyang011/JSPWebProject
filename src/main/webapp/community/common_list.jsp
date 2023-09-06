<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="utils.BoardPage"%>
<%@page import="board.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="board.BoardDAO"%>
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
String tname = session.getAttribute("tname").toString();
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