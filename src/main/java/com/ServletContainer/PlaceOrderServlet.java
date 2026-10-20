
package com.ServletContainer;

import com.dao.OrderDao;
import com.entity.CheckoutItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/placeOrder")
public class PlaceOrderServlet extends HttpServlet {

    private final OrderDao orderDao = new OrderDao();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect(
                    request.getContextPath() + "/login.jsp");
            return;
        }

        String username =
                String.valueOf(session.getAttribute("username"));

        // These names must match checkout.jsp.
        String address = request.getParameter("address");
        String paymentMethod = request.getParameter("paymentOption");

        try {
            long orderId = orderDao.placeOrder(
                    username, address, paymentMethod);

            // Redirect only after the database transaction commits.
            response.sendRedirect(
                    request.getContextPath()
                            + "/myOrders?placed=1&orderId=" + orderId);
            return;

        } catch (IllegalArgumentException | IllegalStateException e) {

            request.setAttribute("errorMessage", e.getMessage());

        } catch (Exception e) {

            getServletContext().log(
                    "Error placing QuickShop order for user: " + username,
                    e);

            request.setAttribute(
                    "errorMessage",
                    "Your order could not be placed. Please check your "
                            + "cart and try again. If the problem continues, "
                            + "check the server logs.");
        }

        // Keep the customer on checkout and show the actual validation error.
        try {
            List<CheckoutItem> items =
                    orderDao.getCheckoutItems(username);

            BigDecimal total = BigDecimal.ZERO;

            for (CheckoutItem item : items) {
                total = total.add(item.getSubtotal());
            }

            request.setAttribute("checkoutItems", items);
            request.setAttribute("cartTotal", total);

            request.getRequestDispatcher("/checkout.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            getServletContext().log(
                    "Could not reload checkout for user: " + username, e);

            throw new ServletException(
                    "The order failed and checkout could not be reloaded. "
                            + "Check the Tomcat logs for the database error.",
                    e);
        }
    }
}
