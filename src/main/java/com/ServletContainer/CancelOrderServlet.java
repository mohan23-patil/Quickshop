
package com.ServletContainer;

import com.dao.OrderDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/cancelOrder")
public class CancelOrderServlet extends HttpServlet {

    private final OrderDao orderDao = new OrderDao();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String ctx = request.getContextPath();
        HttpSession session = request.getSession(false);

        if (session == null ||
                session.getAttribute("username") == null) {

            response.sendRedirect(ctx + "/login.jsp");
            return;
        }

        String username =
                (String) session.getAttribute("username");

        String orderIdValue = request.getParameter("orderId");

        try {
            if (orderIdValue == null ||
                    !orderIdValue.matches("\\d+")) {

                throw new IllegalArgumentException(
                        "Invalid order ID.");
            }

            long orderId = Long.parseLong(orderIdValue);

            if (orderId <= 0) {
                throw new IllegalArgumentException(
                        "Invalid order ID.");
            }

            orderDao.cancelOrder(orderId, username);

            response.sendRedirect(
                    ctx + "/myOrders?cancelled=1");

        } catch (IllegalArgumentException |
                 IllegalStateException e) {

            response.sendRedirect(
                    ctx + "/myOrders?cancelError=1");

        } catch (Exception e) {

            getServletContext().log(
                    "Error cancelling QuickShop order.", e);

            response.sendRedirect(
                    ctx + "/myOrders?cancelError=1");
        }
    }
}
