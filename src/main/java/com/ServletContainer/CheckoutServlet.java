package com.ServletContainer;

import com.dao.OrderDao;
import com.dao.ProductDao;
import com.entity.CheckoutItem;
import com.entity.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    private final OrderDao orderDao = new OrderDao();
    private final ProductDao productDao = new ProductDao();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check login
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect(
                    request.getContextPath() + "/login.jsp");
            return;
        }

        String username =
                String.valueOf(session.getAttribute("username"));

        // Product ID is present for Buy Now
        String productId = request.getParameter("productId");

        try {
            List<CheckoutItem> items = new ArrayList<>();

            if (productId != null && !productId.trim().isEmpty()) {

                // BUY NOW: Load only the selected product
                Product product =
                        productDao.getProductDetailsById(productId.trim());

                if (product == null) {
                    response.sendError(
                            HttpServletResponse.SC_NOT_FOUND,
                            "Product not found.");
                    return;
                }

                if (product.getProductQty() <= 0) {
                    response.sendRedirect(
                            request.getContextPath()
                                    + "/viewAllProduct?message=outofstock");
                    return;
                }

                CheckoutItem item = new CheckoutItem(
                        product.getProductId(),
                        product.getProductName(),
                        product.getImage(),
                        1,
                        product.getProductQty(),
                        BigDecimal.valueOf(product.getProductPrice())
                );

                items.add(item);

            } else {

                // CART CHECKOUT: Load all cart products
                items = orderDao.getCheckoutItems(username);

                if (items.isEmpty()) {
                    response.sendRedirect(
                            request.getContextPath()
                                    + "/viewCart?message=empty");
                    return;
                }
            }

            // Calculate total
            BigDecimal total = BigDecimal.ZERO;

            for (CheckoutItem item : items) {
                total = total.add(item.getSubtotal());
            }

            request.setAttribute("checkoutItems", items);
            request.setAttribute("cartTotal", total);

            // Remember checkout type for the next step
            request.setAttribute(
                    "checkoutType",
                    (productId != null && !productId.trim().isEmpty())
                            ? "BUY_NOW"
                            : "CART"
            );

            request.getRequestDispatcher("/checkout.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            throw new ServletException(
                    "Unable to load checkout details.", e);
        }
    }
}
