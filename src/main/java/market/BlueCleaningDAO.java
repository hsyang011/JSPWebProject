package market;

import java.util.ArrayList;
import java.util.List;

import common.JDBConnect;

public class BlueCleaningDAO extends JDBConnect {

	// 블루클리닝 신청 의뢰
	public int applicationInsert(BlueCleaningDTO dto) {
		int result = 0;
		String query = " INSERT INTO bluecleaning VALUES (seq_bluecleaning_num.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getName());
			psmt.setString(3, dto.getAddr());
			psmt.setString(4, dto.getTel());
			psmt.setString(5, dto.getMobile());
			psmt.setString(6, dto.getEmail());
			psmt.setString(7, dto.getCleaning_type());
			psmt.setString(8, dto.getArea());
			psmt.setString(9, dto.getCleaning_date());
			psmt.setString(10, dto.getApplication_type());
			psmt.setString(11, dto.getEtc());
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("블루클리닉 신청 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}
	
	// 관리자 모드에서 회원의 아이디, 이름, 이메일 정보 가져오기
	public List<BlueCleaningDTO> allApp() {
		List<BlueCleaningDTO> bcList = new ArrayList<BlueCleaningDTO>();
		// 동적 쿼리문 작성
		String query = " SELECT * FROM bluecleaning ";
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			// rs가 존재할 경우 false반환
			while (rs.next()) {
				BlueCleaningDTO dto = new BlueCleaningDTO();
				dto.setNum(rs.getString("num"));
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setAddr(rs.getString("addr"));
				dto.setTel(rs.getString("tel"));
				dto.setMobile(rs.getString("mobile"));
				dto.setEmail(rs.getString("email"));
				dto.setCleaning_type(rs.getString("cleaning_type"));
				dto.setArea(rs.getString("area"));
				dto.setCleaning_date(rs.getString("cleaning_date"));
				dto.setApplication_type(rs.getString("application_type"));
				dto.setEtc(rs.getString("etc"));
				
				bcList.add(dto);
			}
		} catch (Exception e) {
			System.out.println("블루클리닝 신청 조회 중 예외 발생");
			e.printStackTrace();
		}
		return bcList; 
	}
	
	// 블루클리닉 신청 접수 취소
	public int bcCancel(String num) {
		int result = 0;
		String query = " DELETE FROM bluecleaning WHERE num=? ";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, num);
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("블루클리닉 신청 접수 취소 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}
	
}
