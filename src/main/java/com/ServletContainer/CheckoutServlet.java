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

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    private final OrderDao orderDao = new OrderDao();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String username = String.valueOf(session.getAttribute("username"));

        try {
            List<CheckoutItem> items =
                    orderDao.getCheckoutItems(username);

            if (items.isEmpty()) {
                response.sendRedirect(
                        request.getContextPath() + "/viewCart?message=empty");
                return;
            }

            BigDecimal total = BigDecimal.ZERO;

            for (CheckoutItem item : items) {
                total = total.add(item.getSubtotal());
            }

            request.setAttribute("checkoutItems", items);
            request.setAttribute("cartTotal", total);

            request.getRequestDispatcher("/checkout.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            throw new ServletException(
                    "Unable to load checkout details.", e);
        }
    }
}