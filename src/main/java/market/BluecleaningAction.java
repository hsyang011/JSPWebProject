package market;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.JSFunction;

@WebServlet("/market/bluecleaningAction.do")
public class BluecleaningAction extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 폼값 받기
		HttpSession sess = req.getSession();
		String id = sess.getAttribute("UserId").toString();
	    String name = req.getParameter("name");
	    String addr = req.getParameter("addr");
	    String tel = req.getParameter("tel1") + "-" + req.getParameter("tel2") + "-" + req.getParameter("tel3");
	    String mobile = req.getParameter("mobile1") + "-" + req.getParameter("mobile2") + "-" + req.getParameter("mobile3");
	    String email = req.getParameter("email1") + "@" + req.getParameter("email2");
	    String cleaning_type = req.getParameter("cleaning_type");
	    String area = req.getParameter("area");
	    String cleaning_date = req.getParameter("cleaning_date");
	    String application_type = req.getParameter("application_type");
	    String etc = req.getParameter("etc");
	    
	    // DTO객체에 저장하기
	    BlueCleaningDTO dto = new BlueCleaningDTO();
	    dto.setId(id);
	    dto.setName(name);
	    dto.setAddr(addr);
	    dto.setTel(tel);
	    dto.setMobile(mobile);
	    dto.setEmail(email);
	    dto.setCleaning_type(cleaning_type);
	    dto.setArea(area);
	    dto.setCleaning_date(cleaning_date);
	    dto.setApplication_type(application_type);
	    dto.setEtc(etc);
	    
	    // DAO객체 생성 및 insert처리
	    BlueCleaningDAO dao = new BlueCleaningDAO();
	    int result = dao.applicationInsert(dto);
	    dao.close();
	    if (result == 1) {
	    	JSFunction.alertLocation(resp, "블루클리닝 견적 의뢰를 접수했습니다.", "../main/main.do");
	    } else {
	    	JSFunction.alertBack(resp, "블루클리닝 견적 의뢰에 오류가 발생했습니다.");
	    }
	}

}
