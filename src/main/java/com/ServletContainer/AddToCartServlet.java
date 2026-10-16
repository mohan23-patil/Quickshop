package com.ServletContainer;


import com.dao.CartDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/addToCart")
public class AddToCartServlet extends HttpServlet
{
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException
    {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("username") == null)
        {
            response.sendRedirect("login.jsp");
            return;
        }

        String username = (String) session.getAttribute("username");
        String productId = request.getParameter("productId");

        CartDao dao = new CartDao();

        int result = dao.addToCart(username, productId);

        if (result > 0)
        {
            response.sendRedirect("viewCart");
        }
        else
        {
            response.sendRedirect("userViewAllProduct?message=cartError");
        }
    }
}

