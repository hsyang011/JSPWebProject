package market;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/market/basket.do")
public class Basket extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 세션영역의 id와 파라미터로 들어온 값들을 저장한다.
		HttpSession sess = req.getSession();
		String id = sess.getAttribute("UserId").toString();
		String num = req.getParameter("num");
		String selected_quantity = req.getParameter("count");
		String total_price = "";
		String chk = req.getParameter("chk");
		

		BasketDAO bdao = new BasketDAO();
		if (chk != null) {
			// 해당 일련번호에 해당하는 상품의 가격정보를 가져온다.
			ProductsDAO pdao = new ProductsDAO();
			System.out.println("상품수량:"+Integer.parseInt(selected_quantity));
			System.out.println("상품가격:"+ Integer.toString(Integer.parseInt(pdao.getProductInfo(num).getProduct_price().replace(",", "").replace(" ", "")) * Integer.parseInt(selected_quantity)));
			int price = Integer.parseInt(pdao.getProductInfo(num).getProduct_price().replace(",", "").replace(" ", "")) * Integer.parseInt(selected_quantity);
			total_price = String.valueOf(price);
			pdao.close();
			
			// 장바구니에 정보를 추가한다.
			BasketDTO bdto = new BasketDTO();
			bdto.setId(id);
			bdto.setNum(num);
			bdto.setSelected_quantity(selected_quantity);
			bdto.setTotal_price(total_price);
			bdao.addProduct(bdto);
		}
		
		// 장바구니에 담긴 모든 정보를 가져온다.
		List<BasketDTO> basketInfo = bdao.basketInfo(id);
		bdao.close();
		
		// 리퀘스트영역에 저장한 후 포워드 한다.
		req.setAttribute("basketInfo", basketInfo);
		req.getRequestDispatcher("/market/basket.jsp").forward(req, resp);
	}

}
