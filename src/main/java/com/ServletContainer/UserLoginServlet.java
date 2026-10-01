package com.ServletContainer;

import com.dao.UserDao;
import com.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/userLogin")
public class UserLoginServlet extends HttpServlet
{
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String emailId = req.getParameter("emailId");
        String password = req.getParameter("password");
        User user = new UserDao().userLogin(emailId,password);

        if (user != null)
        {
            HttpSession session = req.getSession();
            session.setAttribute("username",user.getFullName());
           resp.sendRedirect("userViewAllProduct");
        }
        else
        {
            req.getRequestDispatcher("userLogin.html").forward(req,resp);
        }
    }
}
