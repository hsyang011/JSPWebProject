package market;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.JSFunction;

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
		String zipcode = req.getParameter("zipcode");
		String addr1 = req.getParameter("addr1");
		String addr2 = req.getParameter("addr2");
		String mobile = req.getParameter("mobile1") + "-" + req.getParameter("mobile2") + "-" + req.getParameter("mobile3");
		String email = req.getParameter("email1") + "@" + req.getParameter("email2");
		String message = req.getParameter("message");
		String payment_amount = req.getParameter("paymentAmount");
		String payment_type = req.getParameter("paymentType");
		
		// dto에 값 저장
		PaymentDTO dto = new PaymentDTO();
		dto.setId(id);
		dto.setName(name);
		dto.setZipcode(zipcode);
		dto.setAddr1(addr1);
		dto.setAddr2(addr2);
		dto.setMobile(mobile);
		dto.setEmail(email);
		dto.setMessage(message);
		dto.setPayment_amount(payment_amount);
		dto.setPayment_type(payment_type);
		
		// 주문완료 로직
		PaymentDAO dao = new PaymentDAO();
		int result = dao.insertPayment(dto);
		
		// 결제가 성공적으로 처리되면 메시지를 띄운 후, 장바구니를 비워준다.
		if (result == 1) {
			if (dao.deleteBasket(id) > 0) JSFunction.alertLocation(resp, "결제가 완료되었습니다!", "../market/products.do");
		} else {
			JSFunction.alertBack(resp, "결제 중 오류가 발생되었습니다.");
		}
		
		dao.close();
	}

}
