package com.ServletContainer;

import com.dao.CartDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/deleteCart")
public class DeleteCartServlet extends HttpServlet
{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException
    {
        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("username") == null)
        {
            resp.sendRedirect("login.jsp");
            return;
        }

        String username = (String) session.getAttribute("username");
        String productId = req.getParameter("productId");

        if (productId == null || productId.trim().isEmpty())
        {
            resp.sendRedirect(req.getContextPath() + "/viewCart");
            return;
        }

        int k = new CartDao().deleteCartItem(username, productId);

        resp.sendRedirect(req.getContextPath() + "/viewCart");
    }
}