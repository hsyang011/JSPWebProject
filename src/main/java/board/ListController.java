package board;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.BoardPage;

@WebServlet("/board/list.do")
public class ListController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		///////////////////////////////////////////////////////////////////////////////////////////////
		///////////////////////////////////////////////////////////////////////////////////////////////
		BoardDAO dao = new BoardDAO();
		
		// 검색어가 있는 경우 클라이언트가 선택한 필드명과 검색어를 저장할 Map컬렉션을 생성한다.
		Map<String, Object> map = new HashMap<String, Object>();

		/* 검색하면 현재페이지로 폼값이 전송된다. */
		String keyField = req.getParameter("keyField");
		String keyString = req.getParameter("keyString");
		if (keyString != null) {
			map.put("keyField", keyField);
			map.put("keyString", keyString);
		}

		// 파라미터로 들어온 테이블 이름 가져오기
		String tname = req.getParameter("tname");
		System.out.println("테이블명 가져왔을까요?" + tname);
		map.put("tname", tname);

		// Map컬렉션을 인수로 게시물의 갯수를 카운트 한다.
		int totalCount = dao.selectCount(map);

		/*** 페이지 처리 start ***/
		// 애플리케이션 객체 가져오기
		ServletContext app = getServletContext();
		int pageSize = Integer.parseInt(app.getInitParameter("POSTS_PER_PAGE"));
		int blockPage = Integer.parseInt(app.getInitParameter("PAGES_PER_BLOCK"));
		int totalPage = (int)Math.ceil((double)totalCount / pageSize);

		int pageNum = 1;
		String pageTemp = req.getParameter("pageNum");
		if (pageTemp!=null && !pageTemp.equals("")) {
			pageNum = Integer.parseInt(pageTemp);
		}

		int start = (pageNum - 1)*pageSize + 1;
		int end = pageNum*pageSize;
		map.put("start", start);
		map.put("end", end);
		/*** 페이지 처리 end ***/

		// 페이지 처리
		List<BoardDTO> boardLists = dao.selectListPage(map);

		dao.close();
		
		
		
		
		// 뷰에 전달할 매개변수 추가
		String pagingImg = BoardPage.pagingImg(totalCount, pageSize, blockPage, pageNum, "../board/list.do?tname=" + tname);
		// 페이지 번호
		map.put("pagingImg", pagingImg);
		// 전체게시물의 갯수
		map.put("totalCount", totalCount);
		// 한 페이지에 출력할 갯수
		map.put("pageSize", pageSize);
		// 현재페이지 번호
		map.put("pageNum", pageNum);
		
		// view(JSP페이지)로 전달할 데이터를 request영역에 저장
		req.setAttribute("boardLists", boardLists);
		req.setAttribute("map", map);
		// 포워드
		// 테이블 명에 따라서 포워드 페이지 결정
		String url = "/community/list.jsp?tname=" + tname;
		req.getRequestDispatcher(url).forward(req, resp);
	}

}