package membership;

import common.JDBConnect;

public class MemberDAO extends JDBConnect {

	// 회원가입
	public int joinInsert(MemberDTO dto) {
		int result = 0;
		String query = " INSERT INTO member VALUES "
				+ " (?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getName());
			psmt.setString(2, dto.getId());
			psmt.setString(3, dto.getPass());
			psmt.setString(4, dto.getTel());
			psmt.setString(5, dto.getMobile());
			psmt.setString(6, dto.getEmail());
			psmt.setString(7, dto.getMailing());
			psmt.setString(8, dto.getZipcode());
			psmt.setString(9, dto.getAddr1());
			psmt.setString(10, dto.getAddr2());
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("회원가입 중 예외 발생");
			e.printStackTrace();
		}
		
		return result;
	}
	
	// 회원정보 수정
	public int memberEdit(MemberDTO dto) {
		int result = 0;
		String query = " UPDATE member "
				+ " SET pass=?, tel=?, mobile=?, email=?, mailing=?, zipcode=?, addr1=?, addr2=? "
				+ " WHERE name=? AND id=? ";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getPass());
			psmt.setString(2, dto.getTel());
			psmt.setString(3, dto.getMobile());
			psmt.setString(4, dto.getEmail());
			psmt.setString(5, dto.getMailing());
			psmt.setString(6, dto.getZipcode());
			psmt.setString(7, dto.getAddr1());
			psmt.setString(8, dto.getAddr2());
			psmt.setString(9, dto.getName());
			psmt.setString(10, dto.getId());
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("회원정보 수정 중 예외 발생");
			e.printStackTrace();
		}
		
		return result;
	}

	// 로그인
	public MemberDTO getMemberDTO(String uid, String upass) {
		MemberDTO dto = new MemberDTO();
		String query = " SELECT * FROM member WHERE id=? AND pass=? ";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, uid);
			psmt.setString(2, upass);
			rs = psmt.executeQuery();
			
			if (rs.next()) {
				dto.setName(rs.getString(1));
				dto.setId(rs.getString(2));
				dto.setPass(rs.getString(3));
				dto.setTel(rs.getString(4));
				dto.setMobile(rs.getString(5));
				dto.setEmail(rs.getString(6));
				dto.setMailing(rs.getString(7));
				dto.setZipcode(rs.getString(8));
				dto.setAddr1(rs.getString(9));
				dto.setAddr2(rs.getString(10));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	// 아이디 찾기
	public String getMemberId(String uname, String uemail) {
		String id = null;
		String query = " SELECT id FROM member WHERE name=? AND email=? ";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, uname);
			psmt.setString(2, uemail);
			rs = psmt.executeQuery();
			
			if (rs.next()) {
				id = rs.getString("id");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return id;
	}
	
	// 비밀번호 찾기
	public String getMemberPw(String uid, String uname, String uemail) {
		String pw = null;
		String query = " SELECT pass FROM member WHERE id=? AND name=? AND email=? ";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, uid);
			psmt.setString(2, uname);
			psmt.setString(3, uemail);
			rs = psmt.executeQuery();
			
			if (rs.next()) {
				pw = rs.getString("pass");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return pw;
	}
	
}
