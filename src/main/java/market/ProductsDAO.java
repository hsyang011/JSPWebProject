package market;

import java.util.ArrayList;
import java.util.List;

import common.JDBConnect;

public class ProductsDAO extends JDBConnect {

	// 상품정보를 모두 가져오기
	public List<ProductsDTO> allProducts() {
		List<ProductsDTO> products = new ArrayList<ProductsDTO>();
		// 정적쿼리문 작성
		String query = " SELECT num, product_image, product_name, to_char(product_price, '999,999,000') product_price FROM products ";
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()) {
				ProductsDTO dto = new ProductsDTO();
				dto.setNum(rs.getString("num"));
				dto.setProduct_image(rs.getString("product_image"));
				dto.setProduct_name(rs.getString("product_name"));
				dto.setProduct_price(rs.getString("product_price"));
				products.add(dto);
			}
		} catch (Exception e) {
			System.out.println("상품 정보를 가져오는 중 예외 발생");
			e.printStackTrace();
		}
		return products;
	}
	
	// 일련번호에 해당하는 상품정보를 가져오기
	public ProductsDTO getProductInfo(String num) {
		ProductsDTO dto = new ProductsDTO();
		String query = " SELECT num, product_image, product_name, to_char(product_price, '999,999,000') product_price FROM products "
				+ " WHERE num=? ";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, num);
			rs = psmt.executeQuery();
			if (rs.next()) {
				dto.setNum(rs.getString("num"));
				dto.setProduct_image(rs.getString("product_image"));
				dto.setProduct_name(rs.getString("product_name"));
				dto.setProduct_price(rs.getString("product_price"));
			}
		} catch (Exception e) {
			System.out.println("상품 상세정보를 가져오는 중 예외 발생");
			e.printStackTrace();
		}
		return dto;
	}
	
}
