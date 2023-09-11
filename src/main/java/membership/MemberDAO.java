package membership;

import java.util.ArrayList;
import java.util.List;

import common.JDBConnect;

public class MemberDAO extends JDBConnect {
	
	// 아이디 중복확인을 위한 메소드 정의
	public boolean idOverlap(String id) {
		// 동적 쿼리문 작성
		String query = " SELECT id FROM member WHERE id=? ";
		try {
			psmt = con.prepareStatement(query);
			// 첫번째 인파라미터에 매개변수 id를 대입
			psmt.setString(1, id);
			// 쿼리 실행
			rs = psmt.executeQuery();
			
			// rs가 존재할 경우 false반환
			if (rs.next()) {
				return false;
			}
		} catch (Exception e) {
			System.out.println("아이디 중복확인 중 예외 발생");
			e.printStackTrace();
		}
		// if문에서 걸리지 않았다면 true반환
		return true;
	}

	// 회원가입
	public int joinInsert(MemberDTO dto) {
		int result = 0;
		String query = " INSERT INTO member (name, id, pass, tel, mobile, email, mailing, zipcode, addr1, addr2) VALUES "
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
				dto.setGrade(rs.getString(11));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	// 아이디로 주문자 정보 가져오기
	public MemberDTO getMemberDTO(String uid) {
		MemberDTO dto = new MemberDTO();
		String query = " SELECT * FROM member WHERE id=? ";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, uid);
			rs = psmt.executeQuery();
			
			if (rs.next()) {
				dto.setName(rs.getString("name"));
				dto.setMobile(rs.getString("mobile"));
				dto.setEmail(rs.getString("email"));
				dto.setZipcode(rs.getString("zipcode"));
				dto.setAddr1(rs.getString("addr1"));
				dto.setAddr2(rs.getString("addr2"));
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
	
	// 관리자 모드에서 회원의 아이디, 이름, 이메일 정보 가져오기
	public List<MemberDTO> allMembers() {
		List<MemberDTO> members = new ArrayList<MemberDTO>();
		// 동적 쿼리문 작성
		String query = " SELECT id, name, email FROM member WHERE NOT grade='Super' ";
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			// rs가 존재할 경우 false반환
			while (rs.next()) {
				MemberDTO dto = new MemberDTO();
				
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setEmail(rs.getString("email"));
				
				members.add(dto);
			}
		} catch (Exception e) {
			System.out.println("회원 정보 조회 중 예외 발생");
			e.printStackTrace();
		}
		return members; 
	}
	
	// 회원 강제 퇴출
	public int kickMember(String id) {
		int result = 0;
		String query = " DELETE FROM member WHERE id=? ";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, id);
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("회원 퇴출 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}
	
}
