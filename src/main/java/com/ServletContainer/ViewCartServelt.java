package com.ServletContainer;

import com.dao.CartDao;
import com.entity.Cart_Item;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/viewCart")
public class ViewCartServelt extends HttpServlet
{
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException
    {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("username") == null)
        {
            response.sendRedirect("userLogin.html");
            return;
        }

        String username = (String) session.getAttribute("username");

        CartDao dao = new CartDao();

        List<Cart_Item> cartList = dao.viewCart(username);

        request.setAttribute("cartList", cartList);

        request.getRequestDispatcher("cart.jsp")
                .forward(request, response);
    }
}
