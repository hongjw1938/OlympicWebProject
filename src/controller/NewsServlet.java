package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.NewsDAO;
import model.NewsVO;

@WebServlet("/news.do")
public class NewsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		NewsDAO dao = new NewsDAO();
		NewsVO vo = new NewsVO();
        ArrayList<NewsVO>list = dao.listAll();
        
        if(list != null && list.size() > 0) 
        	request.setAttribute("list", list);
        	
        	if("read".equals(request.getParameter("action")) && request.getParameter("newsid") != null){
    			vo = dao.listOne(Integer.parseInt(request.getParameter("newsid")));
    			
    			boolean updateResult = dao.update(vo);
    			
    			if(updateResult){
    				list = dao.listAll();

    				if(list != null && list.size()>0)
    					request.setAttribute("list", list);
    			}
    			request.setAttribute("vo", vo);
    		}

    		else if("delete".equals(request.getParameter("action")) && request.getParameter("newsid") != null){
    			dao.delete(Integer.parseInt(request.getParameter("newsid")));
    			
    			list = dao.listAll();
    			
    			if(list != null && list.size()>0)
    				request.setAttribute("list", list);
    		}
        request.getRequestDispatcher("/jsp/news.jsp").forward(request, response);
        }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
	    NewsDAO dao = new NewsDAO();
	    NewsVO vo = new NewsVO();
	    ArrayList<NewsVO>list = dao.listAll();
	    
		/*vo.setId(Integer.parseInt(request.getParameter("id")));*/
		vo.setWriter(request.getParameter("writer"));
		vo.setTitle(request.getParameter("title"));
		vo.setContent(request.getParameter("content"));
		
		if("insert".equals(request.getParameter("action"))){
			boolean insertResult = dao.insert(vo);
			
			if(insertResult){
				list = dao.listAll();
				
				if(list != null && list.size()>0){
					request.setAttribute("list", list);
				}
			}
		}
		
		else if("update".equals(request.getParameter("action")) && request.getParameter("newsid") != null){
			vo.setId(Integer.parseInt(request.getParameter("newsid")));
			vo.setCnt(dao.listOne(Integer.parseInt(request.getParameter("newsid"))).getCnt()-1);
			
			boolean updateResult = dao.update(vo);
			
			if(updateResult){
				list = dao.listAll();

				if(list != null && list.size()>0)
					request.setAttribute("list", list);
			}
		}
		request.getRequestDispatcher("/jsp/news.jsp").forward(request, response);
	}
}