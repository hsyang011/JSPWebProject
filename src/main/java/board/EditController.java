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

@WebServlet("/board/edit.do")
public class EditController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	// 수정페이지로 진입하면 기존의 내용을 가져와서 쓰기폼에 셋팅한다.
	// 단순한 페이지 이동이므로 get방식 요청이다.
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 세션영역에서 테이블명 가져오기
		HttpSession sess = req.getSession();
		String tname = sess.getAttribute("tname").toString();
		// 일련번호를 받는다.
		String num = req.getParameter("num");
		// DAO객체를 생성한 후 기존 게시물의 내용을 가져온다.
		BoardDAO dao =  new BoardDAO();
		BoardDTO dto = dao.selectView(num, tname);
		// dto객체를 request영역에 저장한 후 포워드한다.
		req.setAttribute("dto", dto);
		req.getRequestDispatcher("/community/sub01_edit.jsp").forward(req, resp);
	}
	
	/* 수정할 내용을 입력한 후 전송된 폼값을 update쿼리문으로 갱신한다.
	게시판은 post방식으로 전송되므로 doPost()를 오버라이딩 한다. */
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 세션영역에서 id값 가져오기
		HttpSession sess = req.getSession();
		String id = sess.getAttribute("UserId").toString();
		String tname = sess.getAttribute("tname").toString();
		// 파라미터에서 각 속성값 가져오기
		String num = req.getParameter("num");
		String prevOfile = req.getParameter("prevOfile");
		String prevSfile = req.getParameter("prevSfile");
		String pass = req.getParameter("pass");
		String title = req.getParameter("title");
		String content = req.getParameter("content");


		BoardDTO dto = new BoardDTO();
		dto.setNum(num);
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
				
				FileUtil.deleteFile(req, "/uploads", prevSfile);
			} else {
				dto.setOfile(prevOfile);
				dto.setSfile(prevSfile);
			}

			// 2. 파일 업로드 외 처리 ====================================
			BoardDAO dao = new BoardDAO();
			int affected = dao.updateEdit(dto, tname);
			dao.close();
			
			if (affected == 1) {
				JSFunction.alertLocation(resp, "수정하기에 성공하였습니다!", "../board/view.do?num="+dto.getNum());
			} else {
				JSFunction.alertBack(resp, "수정하기에 실패하였습니다.");
			}
		} else {
			JSFunction.alertBack(resp, "비밀번호가 틀렸습니다.");
		}
	}

}
