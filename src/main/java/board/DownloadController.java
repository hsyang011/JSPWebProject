package board;

import java.io.IOException;

import fileupload.FileUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import utils.JSFunction;

@WebServlet("/board/download.do")
public class DownloadController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	// 다운로드 링크를 클릭하므로 get방식의 요청
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 파라미터 받기
		String ofile = req.getParameter("ofile"); // 원본 파일명
		String sfile = req.getParameter("sfile"); // 저장된 파일명
		
		// 파일 다운로드
		FileUtil.download(req, resp, "/uploads", sfile, ofile);
	}

}
