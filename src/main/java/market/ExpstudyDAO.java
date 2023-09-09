package market;

import java.util.ArrayList;
import java.util.List;

import common.JDBConnect;

public class ExpstudyDAO extends JDBConnect {

	// 블루클리닝 신청 의뢰
	public int applicationInsert(ExpstudyDTO dto) {
		int result = 0;
		String query = " INSERT INTO expstudy VALUES (seq_expstudy_num.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getName());
			psmt.setString(3, dto.getImpaired());
			psmt.setString(4, dto.getImpaired_type());
			psmt.setString(5, dto.getAssist());
			psmt.setString(6, dto.getAssist_type());
			psmt.setString(7, dto.getTel());
			psmt.setString(8, dto.getMobile());
			psmt.setString(9, dto.getEmail());
			psmt.setString(10, dto.getExp_cake());
			psmt.setString(11, dto.getExp_cookie());
			psmt.setString(12, dto.getExpstudy_date());
			psmt.setString(13, dto.getApplication_type());
			psmt.setString(14, dto.getEtc());
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("체험학습신청 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}
	
	// 관리자 모드에서 회원의 아이디, 이름, 이메일 정보 가져오기
	public List<ExpstudyDTO> allApp() {
		List<ExpstudyDTO> exList = new ArrayList<ExpstudyDTO>();
		// 동적 쿼리문 작성
		String query = " SELECT * FROM expstudy ";
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			// rs가 존재할 경우 false반환
			while (rs.next()) {
				ExpstudyDTO dto = new ExpstudyDTO();
				dto.setNum(rs.getString("num"));
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setImpaired(rs.getString("impaired"));
				dto.setImpaired_type(rs.getString("impaired_type"));
				dto.setAssist(rs.getString("assist"));
				dto.setAssist_type(rs.getString("assist_type"));
				dto.setTel(rs.getString("tel"));
				dto.setMobile(rs.getString("mobile"));
				dto.setEmail(rs.getString("email"));
				dto.setExp_cake(rs.getString("exp_cake"));
				dto.setExp_cookie(rs.getString("exp_cookie"));
				dto.setExpstudy_date(rs.getString("expstudy_date"));
				dto.setApplication_type(rs.getString("application_type"));
				dto.setEtc(rs.getString("etc"));
				
				exList.add(dto);
			}
		} catch (Exception e) {
			System.out.println("체험학습신청 조회 중 예외 발생");
			e.printStackTrace();
		}
		return exList; 
	}
	
	// 블루클리닉 신청 접수 취소
	public int exCancel(String num) {
		int result = 0;
		String query = " DELETE FROM expstudy WHERE num=? ";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, num);
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("체험학습신청 접수 취소 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}

}
