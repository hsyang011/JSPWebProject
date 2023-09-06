package board;

import java.io.IOException;

import fileupload.FileUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import membership.MemberDAO;
import utils.JSFunction;

@WebServlet("/board/write.do")
public class WriteController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	/* 글쓰기 페이지로 진입할 때는 다른 로직없이 포워드만 진행한다. */
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("/community/sub01_write.jsp").forward(req, resp);
	}
	
	// 글쓰기는 post방식이 전송이므로 doPost()에서 요청을 처리한다.
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 세션영역에서 id값 가져오기
		HttpSession sess = req.getSession();
		String id = sess.getAttribute("UserId").toString();
		// 세션영역에서 테이블명 가져오기
		String tname = sess.getAttribute("tname").toString();
		String sequence = sess.getAttribute("seqname").toString();
		// 파라미터에서 각 속성값 가져오기
		String pass = req.getParameter("pass");
		String title = req.getParameter("title");
		String content = req.getParameter("content");



		BoardDTO dto = new BoardDTO();
		dto.setId(id);
		dto.setTitle(title);
		dto.setContent(content);
		

		if (new MemberDAO().getMemberDTO(id, pass).getId() != null) {
			// 1. 파일 업로드 처리
			// 업로드 디렉토리의 물리적 경로 확인
			String saveDirectory = req.getServletContext().getRealPath("/uploads/");
			// 파일 업로드
			String originalFileName = "";
			try {
				// 업로드가 정상적으로 완료되면 원본파일명을 반환한다.
				originalFileName = FileUtil.uploadFile(req, saveDirectory);
			} catch (Exception e) {
				/* 파일 업로드시 오류가 발생되면 경고창을 띄운 후 작성페이지로 이동한다. */
				JSFunction.alertBack(resp, "파일 업로드 오류입니다.");
				e.printStackTrace();
				return;
			}
			
			// 첨부파일이 정상적으로 등록되어 원본파일명이 반환되었다면
			if (originalFileName != "") {
				String saveFileName = FileUtil.renameFile(saveDirectory, originalFileName);
				dto.setOfile(originalFileName);
				dto.setSfile(saveFileName);
			}
	
			// 2. 파일 업로드 외 처리 ====================================
			BoardDAO dao = new BoardDAO();
			int result = dao.insertWrite(dto, tname, sequence);
			dao.close();
			
			
			if (result == 1) {
				JSFunction.alertLocation(resp, "글쓰기에 성공하였습니다!", "../board/list.do");
			} else {
				JSFunction.alertBack(resp, "글쓰기에 실패하였습니다.");
			}
		} else {
			JSFunction.alertBack(resp, "비밀번호가 틀렸습니다.");
		}
	}

}
