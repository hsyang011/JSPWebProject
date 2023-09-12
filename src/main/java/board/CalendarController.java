package board;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.JSFunction;

@WebServlet("/board/calendar.do")
public class CalendarController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 세션영역에 저장된 아이디와 이름을 받는다.
		HttpSession sess = req.getSession();
		if (sess.getAttribute("UserId") == null) {
			JSFunction.alertLocation(resp, "로그인 후 이용해주십시오.", "../member/login.jsp");
			return;
		}
		
		String id = sess.getAttribute("UserId").toString();
		String name = sess.getAttribute("UserName").toString();
		// 파라미터로 값 전송 받는다.
		String schedule = req.getParameter("schedule");
		String year = req.getParameter("year");
		String month = req.getParameter("month");
		String day = req.getParameter("day");
		if (Integer.parseInt(month) < 10) {
			month = "0"+month;
		}
		if (Integer.parseInt(day) < 10) {
			day = "0"+day;
		}
		String date = year+"/"+month+"/"+day;
		
		// DTO객체를 생성하여 멤버변수를 초기화 한다.
		CalendarDTO dto = new CalendarDTO();
		dto.setId(id);
		dto.setName(name);
		dto.setSchedule(schedule);
		dto.setScheduleDate(date);
		
		// DAO를 생성하고, DB에 insert를 한다.
		CalendarDAO dao = new CalendarDAO();
		int result = dao.insertSchedule(dto);
		dao.close();
		
		// 성공 or 실패?
		if (result == 1) {
			// 일정 추가 성공 시 캘린더 페이지로 이동
			JSFunction.alertLocation(resp, "일정 추가가 완료되었습니다!", "../space/calendar.jsp?tname=calendar_board&year="+year+"&month="+month);
		} else {
			// 일정 추가 실패 시 캘린더 페이지로 이동
			JSFunction.alertBack(resp, "일정 추가에 실패하였습니다.");
		}
	}

}
