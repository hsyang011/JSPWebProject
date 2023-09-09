package market;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.JSFunction;

@WebServlet("/market/expstudyAction.do")
public class ExpstudyAction extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 폼값 받기
		HttpSession sess = req.getSession();
		String id = sess.getAttribute("UserId").toString();
	    String name = req.getParameter("name");
	    String impaired = req.getParameter("impaired");
	    String impaired_type = req.getParameter("impaired_type");
	    String assist = req.getParameter("assist");
	    String assist_type = req.getParameter("assist_type");
	    String tel = req.getParameter("tel1") + "-" + req.getParameter("tel2") + "-" + req.getParameter("tel3");
	    String mobile = req.getParameter("mobile1") + "-" + req.getParameter("mobile2") + "-" + req.getParameter("mobile3");
	    String email = req.getParameter("email1") + "@" + req.getParameter("email2");
	    String exp_cake = req.getParameter("exp_cake");
	    String exp_cookie = req.getParameter("exp_cookie");
	    String expstudy_date = req.getParameter("expstudy_date");
	    String application_type = req.getParameter("application_type");
	    String etc = req.getParameter("etc");
	    
	    // DTO객체에 저장하기
	    ExpstudyDTO dto = new ExpstudyDTO();
	    dto.setId(id);
	    dto.setName(name);
	    dto.setImpaired(impaired);
	    dto.setImpaired_type(impaired_type);
	    dto.setAssist(assist);
	    dto.setAssist_type(assist_type);
	    dto.setTel(tel);
	    dto.setMobile(mobile);
	    dto.setEmail(email);
	    dto.setExp_cake(exp_cake);
	    dto.setExp_cookie(exp_cookie);
	    dto.setExpstudy_date(expstudy_date);
	    dto.setApplication_type(application_type);
	    dto.setEtc(etc);
	    
	    // DAO객체 생성 및 insert처리
	    ExpstudyDAO dao = new ExpstudyDAO();
	    int result = dao.applicationInsert(dto);
	    dao.close();
	    if (result == 1) {
	    	JSFunction.alertLocation(resp, "체험학습신청을 접수했습니다.", "../main/main.do");
	    } else {
	    	JSFunction.alertBack(resp, "체험학습신청에 오류가 발생했습니다.");
	    }
	}
	
}
