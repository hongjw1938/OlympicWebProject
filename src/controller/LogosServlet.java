package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.LogoDAO;
import model.LogoVO;
import rtest.RJavaGraph;

@WebServlet("/logo")
public class LogosServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	String url = "/jsp/logo.jsp";
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		LogoDAO ldao = new LogoDAO();
		LogoVO lvo = new LogoVO();
		ArrayList<LogoVO> result = ldao.select();
		RJavaGraph rg = new RJavaGraph();

		lvo.setCnt(ldao.listOne(request.getParameter("loc")).getCnt());
		lvo.setLoc(ldao.listOne(request.getParameter("loc")).getLoc());
		
		boolean updateResult = ldao.update(lvo);
		
		if(updateResult){
			result =ldao.select();
			
			if(result != null && result.size()>0)
				request.setAttribute("img_content", rg.logoRImg());
		}
		request.getRequestDispatcher(url).forward(request, response);
	}
}