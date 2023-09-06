package space.board;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import common.JDBConnect;

public class BoardDAO extends JDBConnect {

	// 게시물의 갯수를 카운트하여 int형으로 반환한다.
	public int selectCount(Map<String, Object> map) {
		// 게시물의 갯수를 반환하기 위한 변수
		int totalCount = 0;
		
		// 게시물 수를 얻어오기 위한 쿼리문 작성
		String query = " SELECT COUNT(*) FROM " + map.get("tname").toString() + " ";
		/* 검색어가 있는 경우 where절을 추가하여 조건에 맞는 게시물만 select한다. */
		if (map.get("keyString") != null) {
			query += " WHERE " + map.get("keyField") + " "
					+ " LIKE '%" + map.get("keyString") + "%'";
		}
		
		try {
			// 정적쿼리문 실행을 위한 Statement객체 생성
			stmt = con.createStatement();
			// 쿼리문 실행 후 결과는 ResultSet으로 반환한다.
			rs = stmt.executeQuery(query);
			// 커서를 첫번째 행으로 이동하여 레코드를 읽는다.
			rs.next();
			// 첫번째 컬럼(count함수)의 값을 가져와서 변수에 저장한다.
			totalCount = rs.getInt(1);
		} catch (Exception e) {
			System.out.println("게시물 수를 구하는 중 예외 발생");
			e.printStackTrace();
		}
		
		return totalCount;
	}
	
	/* 작성된 게시물을 인출하여 반환한다. 특히 반환값은 여러개의 레코드를 반환할 수 있고,
	순서를 보장해야 하므로 List컬렉션을 사용한다. */
	public List<BoardDTO> selectListPage(Map<String, Object> map) {
		/* List계열의 컬렉션을 생성한다. 이때 타입매개변수는 board테이블을 대상으로
		하므로 BoardDTO로 설정한다. */
		List<BoardDTO> bbs = new ArrayList<BoardDTO>();
		
		/* 레코드 인출을 위한 select쿼리문 작성. 최근 게시물이 상단에 출력되어야 하므로
		일련번호의 내림차순으로 정렬한다. */
		String query = " SELECT * FROM ( "
				+ " 		SELECT Tb.*, ROWNUM rNum FROM ( "
				+ " 			SELECT S.*, M.name, M.email FROM member M INNER JOIN " + map.get("tname").toString() + " S ON M.id=S.id ";
		if (map.get("keyString") != null) {
			query += " WHERE " + map.get("keyField") + " "
					+ " LIKE '%" + map.get("keyString") + "%' ";
		}
		query += " ORDER BY num DESC "
			+ "	 ) Tb "
			+ " ) "
			+ " WHERE rNum BETWEEN ? AND ? ";
		
		try {
			// 쿼리 실행 및 결과셋 반환
			psmt = con.prepareStatement(query);
			psmt.setString(1, map.get("start").toString());
			psmt.setString(2, map.get("end").toString());
			rs = psmt.executeQuery();
			// 2개 이상의 레코드가 반환될 수 있으므로 while문을 사용한다.
			while (rs.next()) {
				// 하나의 레코드를 저장할 수 있는 DTO객체를 생성한다.
				BoardDTO dto = new BoardDTO();
				
				// setter를 이용해서 각 컬럼의 값을 멤버변수에 저장한다.
				dto.setId(rs.getString("id"));
				dto.setNum(rs.getString("num"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setPostdate(rs.getDate("postdate"));
				dto.setVisitcount(rs.getString("visitcount"));
				dto.setOfile(rs.getString("ofile"));
				dto.setSfile(rs.getString("sfile"));
				dto.setName(rs.getString("name"));
				dto.setEmail(rs.getString("email"));
				
				// List에 DTO를 추가한다.
				bbs.add(dto);
			}
		} catch (Exception e) {
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		}
		
		// 인출한 레코드를 저장한 List를 호출한 지점으로 반환한다.
		return bbs;
	}
	
	// 게시물의 조회수를 1 증가시킨다.
	public void updateVisitCount(String num, String tname) {
		/* 게시물의 일련번호를 통해 visitcount를 1 증가시킨다. 해당 컬럼은
		number타입이므로 사칙연산이 가능하다. */
		String query = " UPDATE " + tname + " SET "
				+ " visitcount=visitcount+1 "
				+ " WHERE num=? ";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, num);
			psmt.executeQuery();
		} catch (Exception e) {
			System.out.println("게시물 조회수 증가 중 예외 발생");
			e.printStackTrace();
		}
	}
	
	// 인수로 전달된 게시물의 일련번호로 하나의 게시물을 인출한다.
	public BoardDTO selectView(String num, String tname) {
		// 하나의 레코드를 저장하기 위한 DTO객체 생성
		BoardDTO dto = new BoardDTO();
		
		/* 내부조인(inner join)을 통해 member테이블의 name, email컬럼까지 select한다. */
		String query = " SELECT S.*, M.name, M.email "
				+ " FROM member M INNER JOIN " + tname + " S "
				+ " ON M.id=S.id "
				+ " WHERE num=? ";
		
		try {
			// 쿼리문의 인파라미터를 설정한 후 쿼리문 실행
			psmt = con.prepareStatement(query);
			psmt.setString(1, num);
			rs = psmt.executeQuery();
			
			/* 일련번호는 중복되지 않으므로 단 1개의 게시물만 인출하게 된다. 따라서
			while문이 아닌 if문으로 처리한다. next()메소드는 ResultSet으로 반환된
			게시물을 확인해서 존재하면 true를 반환해준다. */
			if (rs.next()) {
				dto.setId(rs.getString("id"));
				dto.setNum(rs.getString("num"));
				dto.setTitle(rs.getString("title"));
				/* 각 컬럼의 값을 추출할 때 1부터 시작하는 인덱스와 컬럼명 둘 다 사용할
				수 있다. 날짜인 경우에는 getDate()메소드로 추출할 수 있다. */
				dto.setContent(rs.getString("content"));
				dto.setPostdate(rs.getDate("postdate"));
				dto.setVisitcount(rs.getString("visitcount"));
				dto.setOfile(rs.getString("ofile"));
				dto.setSfile(rs.getString("sfile"));
				dto.setName(rs.getString("name"));
				dto.setEmail(rs.getString("email"));
			}
		} catch (Exception e) {
			
			System.out.println("게시물 상세보기 중 예외 발생");
			e.printStackTrace();
		}
		
		return dto;
	}
	
	// 게시물 입력을 위한 메소드. 폼값이 저장된 DTO객체를 인수로 받는다.
	public int insertWrite(BoardDTO dto, String tname) {
		int result = 0;
		
		try {
			/* 인파라미터가 있는 동적쿼리문으로 insert문을 작성한다. 게시물의 일련번호는
			시퀀스를 통해 자동부여하고, 조회수는 0으로 입력한다. */
			String query = " INSERT INTO " + tname + " ( "
					+ " num, id, title, content, postdate, visitcount, ofile, sfile) "
					+ " VALUES ( "
					+ " seq_space_num.NEXTVAL, ?, ?, ?, sysdate, 0, ?, ?) ";
			
			psmt = con.prepareStatement(query);
			// 인파라미터는 DTO에 저장된 내용으로 채워준다.
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getOfile());
			psmt.setString(5, dto.getSfile());
			// insert쿼리문을 실행한 후 결과값(int)을 반환받는다.
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("게시물 입력 중 예외 발생");
			e.printStackTrace();
		}
		
		return result;
	}
	
	public int deletePost(BoardDTO dto, String tname) {
		int result = 0;
		
		try {
			// 인파라미터가 있는 delete쿼리문 작성
			String query = " DELETE FROM " + tname + " WHERE num=? ";
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getNum());
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("게시물 삭제 중 예외 발생");
			e.printStackTrace();
		}
		
		return result;
	}
	
	// 게시물 수정하기
	public int updateEdit(BoardDTO dto, String tname) {
		int result = 0;
		try {
			// 특정 일련번호에 해당하는 게시물을 수정한다.
			String query = " UPDATE " + tname + " "
					+ " SET title=?, content=?, ofile=?, sfile=? "
					+ " WHERE num=? ";
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getOfile());
			psmt.setString(4, dto.getSfile());
			psmt.setString(5, dto.getNum());
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("게시물 수정 중 예외 발생");
			e.printStackTrace();
		}
		
		return result;
	}
	
}
