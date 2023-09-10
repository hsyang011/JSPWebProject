package market;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/market/market_view.do")
public class MarketView extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 일련번호 가져오기
		String num = req.getParameter("num");
		// 해당 상품 불러오기
		ProductsDAO dao = new ProductsDAO();
		ProductsDTO dto = dao.getProductInfo(num);
		dao.close();
		
		// 리퀘스트영역에 dto를 저장한 후 뷰로 포워드한다.
		req.setAttribute("dto", dto);
		req.getRequestDispatcher("/market/market_view.jsp?num=" + num).forward(req, resp);
	}

}
