package main;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import board.BoardDAO;
import board.BoardDTO;
import utils.CookieManager;

@WebServlet("/main/main.do")
public class MainController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 쿠키를 읽어들인다.
		String savedId = CookieManager.readCookie(req, "SavedId");
		// 쿠키의 값이 OFF이면 빈문자열, 아닐 경우 그대로 유지한다.
		savedId = savedId.equals("OFF") ? "" : savedId;
		
		// savedId가 빈문자열이면 빈문자열로, 아닐 경우 checked문자열을 저장한다.
		String isChecked = savedId=="" ? "" : "checked";
		
		
		// DB연결
		BoardDAO dao = new BoardDAO();
		// DAO로 전달할 파라미터를 저장하기 위한 컬렉션
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("start", 1);
		param.put("end", 4);
		// 공지사항 최근 게시물 4개 인출(board)
		param.put("tname", "notice_board");
		List<BoardDTO> notice = dao.selectListPage(param);
		param.put("tname", "free_board");
		List<BoardDTO> free = dao.selectListPage(param);
		// 사진게시판 최근 게시물 6개 인출
		param.put("end", 6);
		param.put("tname", "photo_board");
		List<BoardDTO> photo = dao.selectListPage(param);
		
		// 각 게시판을 리퀘스트 영역에 저장
		req.setAttribute("notice", notice);
		req.setAttribute("free", free);
		req.setAttribute("photo", photo);
		
		// 포워드할 페이지로 전송할 속성명 저장
		req.setAttribute("savedId", savedId);
		req.setAttribute("isChecked", isChecked);
		// 포워드
		req.getRequestDispatcher("/main/main.jsp").forward(req, resp);
	}

}
