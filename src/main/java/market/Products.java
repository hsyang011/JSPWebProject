package market;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/market/products.do")
public class Products extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 상품정보를 모두 가져온다.
		ProductsDAO dao = new ProductsDAO();
		List<ProductsDTO> products = dao.allProducts();
		dao.close();
		
		// 리퀘스트영역에 저장한 후 products.jsp로 포워드 한다.
		req.setAttribute("products", products);
		req.getRequestDispatcher("/market/products.jsp").forward(req, resp);
	}

}
