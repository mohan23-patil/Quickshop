package com.ServletContainer;

import com.dao.UserDao;
import com.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
@WebServlet("/userRegister")
public class UserRegistrationServlet extends HttpServlet
{
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userId = req.getParameter("userId");
        String fullName = req.getParameter("fullName");
        String emailId = req.getParameter("emailId");
        long mobileNo = Long.parseLong(req.getParameter("mobileNo"));
        String password = req.getParameter("password");
        String address = req.getParameter("address");
        String city = req.getParameter("city");
        String state = req.getParameter("state");
        int pincode = Integer.parseInt(req.getParameter("pincode"));

        User user = new User();
        user.setUserId(userId);
        user.setFullName(fullName);
        user.setEmailId(emailId);
        user.setMobileNo(mobileNo);
        user.setPassword(password);
        user.setAddress(address);
        user.setCity(city);
        user.setState(state);
        user.setPincode(pincode);

        int k = new UserDao().registration(user);
        if (k > 0)
        {
            req.setAttribute("msg","User Registration SuccessFull");
            req.getRequestDispatcher("userLogin.html").forward(req,resp);
        }
        else
        {
            req.setAttribute("msg","User not Registration");
            req.getRequestDispatcher("userRegistration.jsp").forward(req,resp);
        }
    }
}
