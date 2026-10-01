package com.ServletContainer;

import com.dao.AdminDao;
import com.entity.Admin;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/adminRegistration")
public class AdminRegistrationServlet extends HttpServlet
{
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String adminName = req.getParameter("adminName");
        String password = req.getParameter("password");
        String fName = req.getParameter("fName");
        String lName = req.getParameter("lName");
        String emailId = req.getParameter("emailId");
        long mobNo = Long.parseLong(req.getParameter("mobileNo"));

        Admin admin = new Admin();
        admin.setAdminName(adminName);
        admin.setPassword(password);
        admin.setfName(fName);
        admin.setlName(lName);
        admin.setEmailId(emailId);
        admin.setMobileNo(mobNo);

        int k = new AdminDao().adminRegistration(admin);
        if (k > 0)
        {
//            req.setAttribute("msg","Admin Registration SuccessFull");
            req.getRequestDispatcher("adminLogin.html").forward(req,resp);
        }
        else
        {
//            req.setAttribute("msg","Something is Wrong! Failed To Registration");
            req.getRequestDispatcher("adminRegistration.html").forward(req,resp);
        }
    }
}
