package board;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/board/view.do")
public class ViewController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 테이블명 가져오기
		HttpSession sess = req.getSession();
		String tname = sess.getAttribute("tname").toString();
		// 게시물 불러오기
		BoardDAO dao = new BoardDAO();
		// 파라미터로 전달된 일련번호를 받는다.
		String num = req.getParameter("num");
		// 조회수 1 증가
		dao.updateVisitCount(num, tname);
		// 게시물을 인출한다.
		BoardDTO dto = dao.selectView(num, tname);
		dao.close();
		
		
		/* 내용의 경우 Enter를 통해 줄바꿈을 하게 되므로 웹브라우저 출력시 <br>로 변경해야 한다. */
		String ext = null, fileName = dto.getSfile();
		if (fileName != null) {
			ext = fileName.substring(fileName.lastIndexOf(".")+1);
		}
		String[] mimeStr = { "png", "jpg", "gif" };
		List<String> mimeList = Arrays.asList(mimeStr);
		boolean isImage = false;
		if (mimeList.contains(ext)) {
			isImage = true;
		}
		
		// 게시물(dto)을 request영역에 저장한 후 뷰로 포워드한다.
		req.setAttribute("dto", dto);
		req.setAttribute("isImage", isImage);
		// 테이블 명에 따라서 포워드 페이지 결정
		String url = "/community/sub01_view.jsp";
		switch (tname) {
		case "staff_board":
			url = "/community/sub01_view.jsp";
			break;
		case "protector_board":
			url = "/community/sub02_view.jsp";
			break;
		}
		req.getRequestDispatcher(url).forward(req, resp);
	}

}
