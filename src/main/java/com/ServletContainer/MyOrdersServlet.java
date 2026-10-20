
package com.ServletContainer;

import com.dao.OrderDao;
import com.entity.Order;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/myOrders")
public class MyOrdersServlet extends HttpServlet {

    private final OrderDao orderDao = new OrderDao();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect(
                    request.getContextPath() + "/login.jsp");
            return;
        }

        String username =
                String.valueOf(session.getAttribute("username"));

        try {
            List<Order> orders =
                    orderDao.getOrdersByUsername(username);

            request.setAttribute("orders", orders);

            // Used by myOrders.jsp for the success message.
            request.setAttribute(
                    "placed", request.getParameter("placed"));

            request.setAttribute(
                    "newOrderId", request.getParameter("orderId"));

            request.getRequestDispatcher("/myOrders.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            getServletContext().log(
                    "Unable to load orders for user: " + username, e);

            throw new ServletException(
                    "Unable to load your orders. Check the server logs.", e);
        }
    }
}
