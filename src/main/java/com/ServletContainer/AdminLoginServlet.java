package com.ServletContainer;

import com.dao.AdminDao;
import com.entity.Admin;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/adminLogin")
public class AdminLoginServlet extends HttpServlet
{
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException
    {
        String adminName = req.getParameter("adminName");
        String password = req.getParameter("password");

        Admin admin = new AdminDao().adminLogin(adminName, password);

        if (admin != null)
        {
            HttpSession session = req.getSession();
            session.setAttribute("fName", admin.getfName());
            resp.sendRedirect(req.getContextPath() + "/viewAllProduct");
        }

    }
}

