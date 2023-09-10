package market;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/market/paymentProcess.do")
public class PaymentProcess extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 세션영역에서 id값 가져오기
		HttpSession sess = req.getSession();
		String id = sess.getAttribute("UserId").toString();
		// 파라미터에서 각 속성값 가져오기
		String name = req.getParameter("name");
		String message = req.getParameter("message");
	}

}
