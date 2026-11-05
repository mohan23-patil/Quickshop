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

@WebServlet("/placeOrder")
public class PlaceOrderServlet extends HttpServlet {

    private final OrderDao orderDao = new OrderDao();
    private final ProductDao productDao = new ProductDao();

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

        String checkoutType = request.getParameter("checkoutType");
        String productId = request.getParameter("productId");
        String paymentMethod = request.getParameter("paymentOption");

        // Read and combine all delivery address fields.
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String addressLine = request.getParameter("address");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String pincode = request.getParameter("pincode");

        String address =
                "Name: " + safe(fullName)
                        + ", Phone: " + safe(phone)
                        + ", Address: " + safe(addressLine)
                        + ", City: " + safe(city)
                        + ", State: " + safe(state)
                        + ", Pincode: " + safe(pincode);

        try {
            if (isBlank(fullName) || isBlank(phone)
                    || isBlank(addressLine) || isBlank(city)
                    || isBlank(state) || isBlank(pincode)) {
                throw new IllegalArgumentException(
                        "Please fill in all delivery address fields.");
            }

            if (isBlank(paymentMethod)) {
                throw new IllegalArgumentException(
                        "Please select a payment method.");
            }

            long orderId;

            if ("BUY_NOW".equalsIgnoreCase(checkoutType)) {

                if (isBlank(productId)) {
                    throw new IllegalArgumentException(
                            "Please select a valid product.");
                }

                // Places an order for one selected product only.
                // This DAO method must validate stock and price
                // inside a database transaction.
                orderId = orderDao.placeBuyNowOrder(
                        username,
                        productId.trim(),
                        address,
                        paymentMethod
                );

            } else {

                // Existing cart checkout.
                orderId = orderDao.placeOrder(
                        username,
                        address,
                        paymentMethod
                );
            }

            // Redirect after the DAO transaction succeeds.
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
                    "Your order could not be placed. Please try again.");
        }

        // Reload the same checkout type if validation/order placement fails.
        try {
            List<CheckoutItem> items = new ArrayList<>();

            if ("BUY_NOW".equalsIgnoreCase(checkoutType)
                    && !isBlank(productId)) {

                Product product =
                        productDao.getProductDetailsById(productId.trim());

                if (product != null) {
                    items.add(new CheckoutItem(
                            product.getProductId(),
                            product.getProductName(),
                            product.getImage(),
                            1,
                            product.getProductQty(),
                            BigDecimal.valueOf(product.getProductPrice())
                    ));
                }

            } else {
                items = orderDao.getCheckoutItems(username);
            }

            BigDecimal total = BigDecimal.ZERO;

            for (CheckoutItem item : items) {
                total = total.add(item.getSubtotal());
            }

            request.setAttribute("checkoutItems", items);
            request.setAttribute("cartTotal", total);
            request.setAttribute(
                    "checkoutType",
                    "BUY_NOW".equalsIgnoreCase(checkoutType)
                            ? "BUY_NOW" : "CART");

            request.setAttribute("buyNowProductId", productId);

            request.getRequestDispatcher("/checkout.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            getServletContext().log(
                    "Could not reload checkout for user: " + username, e);

            throw new ServletException(
                    "Order failed and checkout could not be reloaded.", e);
        }
    }

    private String safe(String value) {
        return value == null ? "" : value.trim();
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}