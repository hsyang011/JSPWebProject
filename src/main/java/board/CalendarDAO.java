package board;

import java.util.ArrayList;
import java.util.List;

import common.JDBConnect;

public class CalendarDAO extends JDBConnect {

	// 일정 추가를 insert한다.
	public int insertSchedule(CalendarDTO dto) {
		int result = 0;
		try {
			String query = " INSERT INTO calendar_board VALUES (seq_calendar_num.NEXTVAL, ?, ?, ?, ?) ";
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getName());
			psmt.setString(3, dto.getSchedule());
			psmt.setString(4, dto.getScheduleDate());
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("일정 추가 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}
	
	// 해당 연, 달의 일정정보 가져오기
	public List<CalendarDTO> allSchedule(String year, String month) {
		List<CalendarDTO> scList = new ArrayList<CalendarDTO>();
		String date = year.substring(2) + "/" + month;
		System.out.println("DB의 날짜"+date);
		// 동적 쿼리문 작성
		String query = " SELECT * FROM calendar_board WHERE scheduledate LIKE '%" + date + "%' ";
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()) {
				CalendarDTO dto = new CalendarDTO();
				dto.setName(rs.getString("num"));
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setSchedule(rs.getString("schedule"));
				dto.setScheduleDate(rs.getString("scheduleDate").split(" ")[0]);
				scList.add(dto);
			}
		} catch (Exception e) {
			System.out.println(year+"년"+month+"월 일정 조회 중 예외 발생");
			e.printStackTrace();
		}
		return scList; 
	}
	
}
