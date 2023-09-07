package board;

import java.io.IOException;

import fileupload.FileUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.JSFunction;

@WebServlet("/board/delete.do")
public class DeleteController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String tname = req.getParameter("tname");
		String num = req.getParameter("num");
				
		BoardDAO dao = new BoardDAO();
		// 기존 게시물의 내용을 가져온다.
		BoardDTO dto = dao.selectView(num, tname);
		// 게시물 삭제
		int result = dao.deletePost(dto, tname);
		dao.close();
		// 게시물 삭제 성공 시 첨부파일도 삭제
		if (result == 1) {
			String saveFileName = dto.getSfile();
			FileUtil.deleteFile(req, "/uploads", saveFileName);
		}
		
		// 게시물 삭제가 완료되면 목록으로 이동한다.
		JSFunction.alertLocation(resp, "삭제되었습니다.", "../board/list.do?tname=" + tname);
	}

}
