package main;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
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
		
		// 포워드할 페이지로 전송할 속성명 저장
		req.setAttribute("savedId", savedId);
		req.setAttribute("isChecked", isChecked);
		// 포워드
		req.getRequestDispatcher("/main/main.jsp").forward(req, resp);
	}

}
