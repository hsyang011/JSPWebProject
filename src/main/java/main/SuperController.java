package main;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import market.BlueCleaningDAO;
import market.BlueCleaningDTO;
import market.ExpstudyDAO;
import market.ExpstudyDTO;
import membership.MemberDAO;
import membership.MemberDTO;

@WebServlet("/main/super.do")
public class SuperController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 회원정보를 모두 가져온다.
		MemberDAO mdao = new MemberDAO();
		List<MemberDTO> members = mdao.allMembers();
		mdao.close();
		
		// 블루클리닝 의뢰를 모두 가져온다.
		BlueCleaningDAO bcdao = new BlueCleaningDAO();
		List<BlueCleaningDTO> bcList = bcdao.allApp();
		bcdao.close();
		
		// 체험학습신청을 모두 가져온다.
		ExpstudyDAO exdao = new ExpstudyDAO();
		List<ExpstudyDTO> exList = exdao.allApp();
		exdao.close();
		
		// 리퀘스트영역에 저장한 후 super.jsp로 포워드 한다.
		req.setAttribute("members", members);
		req.setAttribute("bcList", bcList);
		req.setAttribute("exList", exList);
		req.getRequestDispatcher("/main/super.jsp").forward(req, resp);
	}
	
}
