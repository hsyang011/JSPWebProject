package market;

import java.util.ArrayList;
import java.util.List;

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
	
	// 관리자 모드에서 회원의 아이디, 이름, 이메일 정보 가져오기
	public List<PaymentDTO> allPayment() {
		List<PaymentDTO> paList = new ArrayList<PaymentDTO>();
		// 동적 쿼리문 작성
		String query = " SELECT * FROM receipt ";
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			// rs가 존재할 경우 false반환
			while (rs.next()) {
				PaymentDTO dto = new PaymentDTO();
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setZipcode(rs.getString("zipcode"));
				dto.setAddr1(rs.getString("addr1"));
				dto.setAddr2(rs.getString("addr2"));
				dto.setMobile(rs.getString("mobile"));
				dto.setEmail(rs.getString("email"));
				dto.setMessage(rs.getString("message"));
				dto.setPayment_amount(rs.getString("payment_amount"));
				dto.setPayment_type(rs.getString("payment_type"));
				
				paList.add(dto);
			}
		} catch (Exception e) {
			System.out.println("결제 요청 조회 중 예외 발생");
			e.printStackTrace();
		}
		return paList; 
	}
	
	// 결제 요청 취소
	public int paCancel(String id) {
		int result = 0;
		String query = " DELETE FROM receipt WHERE id=? ";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, id);
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("결제 요청 취소 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}
	
}
