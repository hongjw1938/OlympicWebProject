package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.MascotDAO;
import model.MascotVO;
import rtest.RJavaGraph;

@WebServlet("/mascots")
public class MascotsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	String url = "/jsp/mascot.jsp";
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MascotDAO mdao = new MascotDAO();
		MascotVO mvo = new MascotVO();
		ArrayList<MascotVO> result = mdao.select();
		RJavaGraph rg = new RJavaGraph();

		mvo.setCnt(mdao.listOne(request.getParameter("name")).getCnt());
		mvo.setMas(mdao.listOne(request.getParameter("name")).getMas());
		
		boolean updateResult = mdao.update(mvo);
		
		if(updateResult){
			result = mdao.select();

		if(result != null && result.size()>0)
			request.setAttribute("img_content", rg.mascotRImg());
		}
		request.getRequestDispatcher(url).forward(request, response);
	}
}