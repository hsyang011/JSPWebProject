package market;

import common.JDBConnect;

public class PaymentDAO extends JDBConnect {

	// 결제 요청
	public int insertPayment(PaymentDTO dto) {
		int result = 0;
		try {
			String query = " INSERT INTO receipt VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ";
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getName());
			psmt.setString(3, dto.getZipcode());
			psmt.setString(4, dto.getAddr1());
			psmt.setString(5, dto.getAddr2());
			psmt.setString(6, dto.getMobile());
			psmt.setString(7, dto.getEmail());
			psmt.setString(8, dto.getMessage());
			psmt.setString(9, dto.getPayment_amount());
			psmt.setString(10, dto.getPayment_type());
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("결제 처리 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}
	
	// 장바구니 비우기
	public int deleteBasket(String id) {
		int result = 0;
		String query = " DELETE FROM basket WHERE id=? ";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, id);
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("장바구니를 비우는 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}
	
}
