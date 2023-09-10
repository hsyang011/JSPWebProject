package market;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import membership.MemberDAO;
import membership.MemberDTO;

@WebServlet("/market/basketOrder.do")
public class BasketOrder extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 세션영역의 id와 파라미터로 들어온 값들을 저장한다.
		HttpSession sess = req.getSession();
		String id = sess.getAttribute("UserId").toString();
		
		// 장바구니에 담긴 모든 상품정보를 가져온다.
		BasketDAO bdao = new BasketDAO();
		List<BasketDTO> basketInfo = bdao.basketInfo(id);
		
		// id에 관한 정보를 가져온다.
		MemberDAO mdao = new MemberDAO();
		MemberDTO mdto = mdao.getMemberDTO(id);
		
		// 리퀘스트영역에 저장한 후 포워드 한다.
		req.setAttribute("basketInfo", basketInfo);
		req.setAttribute("dto", mdto);
		req.getRequestDispatcher("/market/basketOrder.jsp").forward(req, resp);
	}

}
