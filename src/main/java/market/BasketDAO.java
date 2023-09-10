package market;

import java.util.ArrayList;
import java.util.List;

import common.JDBConnect;

public class BasketDAO extends JDBConnect {

	// 장바구니에 추가
	public int addProduct(BasketDTO dto) {
		int result = 0;
		try {
			String query = " INSERT INTO basket VALUES (?, ?, ?, ?) ";
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getNum());
			psmt.setString(2, dto.getId());
			psmt.setString(3, dto.getSelected_quantity());
			psmt.setString(4, dto.getTotal_price());
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("장바구이네 품목 추가 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}
	
	// 장바구니에 담긴 모든 품목을 가져오기
	public List<BasketDTO> basketInfo(String id) {
		List<BasketDTO> basketInfo = new ArrayList<BasketDTO>();
		String query = " SELECT * FROM basket WHERE id=" + "'" + id + "'";
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()) {
				BasketDTO dto = new BasketDTO();
				dto.setNum(rs.getString("num"));
				dto.setId(rs.getString("id"));
				dto.setSelected_quantity(rs.getString("selected_quantity"));
				dto.setTotal_price(rs.getString("total_price"));
				basketInfo.add(dto);
			}
		} catch (Exception e) {
			System.out.println("장바구니에 담긴 모든 품목을 가져오는 중 예외 발생");
			e.printStackTrace();
		}
		return basketInfo;
	}
	
}
