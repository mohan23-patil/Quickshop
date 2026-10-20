
package com.dao;

import com.dbConnection.DBConnection;
import com.entity.CheckoutItem;
import com.entity.Order;
import com.entity.OrderItem;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class OrderDao {

    public List<CheckoutItem> getCheckoutItems(String username)
            throws SQLException {

        List<CheckoutItem> items = new ArrayList<>();

        String sql =
                "SELECT c.productId, c.quantity, p.productName, " +
                        "p.productPrice, p.productQty, p.image " +
                        "FROM cart_items c " +
                        "JOIN quickshop p ON p.productId = c.productId " +
                        "WHERE c.username = ? ORDER BY c.cartId";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    items.add(new CheckoutItem(
                            rs.getString("productId"),
                            rs.getString("productName"),
                            rs.getString("image"),
                            rs.getInt("quantity"),
                            rs.getInt("productQty"),
                            rs.getBigDecimal("productPrice")
                    ));
                }
            }
        }

        return items;
    }

    public BigDecimal getCartTotal(String username)
            throws SQLException {

        String sql =
                "SELECT COALESCE(SUM(c.quantity * p.productPrice), 0) " +
                        "FROM cart_items c " +
                        "JOIN quickshop p ON p.productId = c.productId " +
                        "WHERE c.username = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);

            try (ResultSet rs = ps.executeQuery()) {
                rs.next();

                BigDecimal total = rs.getBigDecimal(1);

                return total == null ? BigDecimal.ZERO : total;
            }
        }
    }

    public long placeOrder(String username, String address,
                           String paymentMethod) throws Exception {

        if (username == null || username.trim().isEmpty()) {
            throw new IllegalArgumentException(
                    "Please log in before placing an order.");
        }

        if (address == null || address.trim().isEmpty()
                || address.trim().length() > 500) {
            throw new IllegalArgumentException(
                    "Enter a delivery address of at most 500 characters.");
        }

        if (!"COD".equals(paymentMethod)) {
            throw new IllegalArgumentException(
                    "Cash on Delivery is the only available payment method.");
        }

        try (Connection con = DBConnection.getConnection()) {

            con.setAutoCommit(false);

            try {
                List<CheckoutItem> items = new ArrayList<>();
                BigDecimal total = BigDecimal.ZERO;

                /*
                 * Lock the relevant rows while checking stock.
                 * The database tables should use InnoDB for transactions.
                 */
                String selectSql =
                        "SELECT c.productId, c.quantity, p.productName, " +
                                "p.productPrice, p.productQty, p.image " +
                                "FROM cart_items c " +
                                "JOIN quickshop p ON p.productId = c.productId " +
                                "WHERE c.username = ? FOR UPDATE";

                try (PreparedStatement ps =
                             con.prepareStatement(selectSql)) {

                    ps.setString(1, username);

                    try (ResultSet rs = ps.executeQuery()) {
                        while (rs.next()) {

                            String productId =
                                    rs.getString("productId");
                            String name =
                                    rs.getString("productName");
                            int quantity =
                                    rs.getInt("quantity");
                            int stock =
                                    rs.getInt("productQty");
                            BigDecimal price =
                                    rs.getBigDecimal("productPrice");

                            if (quantity <= 0) {
                                throw new IllegalStateException(
                                        "Invalid quantity for " + name + ".");
                            }

                            if (price == null || price.signum() < 0) {
                                throw new IllegalStateException(
                                        "Invalid price for " + name + ".");
                            }

                            if (quantity > stock) {
                                throw new IllegalStateException(
                                        name + " has only " + stock
                                                + " item(s) available.");
                            }

                            items.add(new CheckoutItem(
                                    productId,
                                    name,
                                    rs.getString("image"),
                                    quantity,
                                    stock,
                                    price
                            ));

                            total = total.add(
                                    price.multiply(
                                            BigDecimal.valueOf(quantity)));
                        }
                    }
                }

                // Check whether a cart row refers to a missing product.
                String countSql =
                        "SELECT COUNT(*) FROM cart_items WHERE username = ?";

                int cartRowCount;

                try (PreparedStatement ps =
                             con.prepareStatement(countSql)) {

                    ps.setString(1, username);

                    try (ResultSet rs = ps.executeQuery()) {
                        rs.next();
                        cartRowCount = rs.getInt(1);
                    }
                }

                if (items.isEmpty()) {
                    throw new IllegalStateException(
                            "Your cart is empty. Add products before checkout.");
                }

                if (items.size() != cartRowCount) {
                    throw new IllegalStateException(
                            "Some products are unavailable. Refresh your cart.");
                }

                // Create the main order.
                String orderSql =
                        "INSERT INTO orders " +
                                "(user_name, total_amount, payment_method, " +
                                "payment_status, order_status, delivery_address) " +
                                "VALUES (?, ?, ?, ?, ?, ?)";

                long orderId;

                try (PreparedStatement ps = con.prepareStatement(
                        orderSql, Statement.RETURN_GENERATED_KEYS)) {

                    ps.setString(1, username);
                    ps.setBigDecimal(2, total);
                    ps.setString(3, "COD");
                    ps.setString(4, "Pending");
                    ps.setString(5, "Pending");
                    ps.setString(6, address.trim());

                    int affectedRows = ps.executeUpdate();

                    if (affectedRows != 1) {
                        throw new SQLException(
                                "The order record was not created.");
                    }

                    try (ResultSet keys = ps.getGeneratedKeys()) {
                        if (!keys.next()) {
                            throw new SQLException(
                                    "Unable to generate order ID.");
                        }

                        orderId = keys.getLong(1);
                    }
                }

                // Save every product belonging to the order.
                String itemSql =
                        "INSERT INTO order_items " +
                                "(order_id, product_id, product_name, quantity, price) " +
                                "VALUES (?, ?, ?, ?, ?)";

                // Reduce stock only if enough stock remains.
                String stockSql =
                        "UPDATE quickshop " +
                                "SET productQty = productQty - ? " +
                                "WHERE productId = ? AND productQty >= ?";

                try (PreparedStatement itemPs =
                             con.prepareStatement(itemSql);
                     PreparedStatement stockPs =
                             con.prepareStatement(stockSql)) {

                    for (CheckoutItem item : items) {

                        itemPs.setLong(1, orderId);
                        itemPs.setString(2, item.getProductId());
                        itemPs.setString(3, item.getProductName());
                        itemPs.setInt(4, item.getQuantity());
                        itemPs.setBigDecimal(5, item.getPrice());

                        if (itemPs.executeUpdate() != 1) {
                            throw new SQLException(
                                    "Unable to save order item: "
                                            + item.getProductName());
                        }

                        stockPs.setInt(1, item.getQuantity());
                        stockPs.setString(2, item.getProductId());
                        stockPs.setInt(3, item.getQuantity());

                        if (stockPs.executeUpdate() != 1) {
                            throw new IllegalStateException(
                                    "Stock changed for "
                                            + item.getProductName()
                                            + ". Please try again.");
                        }
                    }
                }

                // Clear only this customer's cart.
                String deleteSql =
                        "DELETE FROM cart_items WHERE username = ?";

                try (PreparedStatement ps =
                             con.prepareStatement(deleteSql)) {

                    ps.setString(1, username);
                    ps.executeUpdate();
                }

                // Commit all changes together.
                con.commit();

                return orderId;

            } catch (Exception e) {

                try {
                    con.rollback();
                } catch (SQLException rollbackError) {
                    e.addSuppressed(rollbackError);
                }

                throw e;

            } finally {
                try {
                    con.setAutoCommit(true);
                } catch (SQLException ignored) {
                    // Connection closes automatically.
                }
            }
        }
    }


    public List<Order> getOrdersByUsername(String username)
            throws SQLException {

        List<Order> orders = new ArrayList<>();

        String orderSql =
                "SELECT order_id, user_name, order_date, total_amount, " +
                        "payment_method, payment_status, order_status, delivery_address " +
                        "FROM orders WHERE user_name = ? ORDER BY order_date DESC";

        String itemSql =
                "SELECT oi.product_id, oi.product_name, oi.quantity, oi.price, " +
                        "p.image AS product_image " +
                        "FROM order_items oi " +
                        "LEFT JOIN quickshop p ON p.productId = oi.product_id " +
                        "WHERE oi.order_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(orderSql)) {

            ps.setString(1, username);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    Order order = new Order();

                    order.setOrderId(rs.getLong("order_id"));
                    order.setUserName(rs.getString("user_name"));
                    order.setOrderDate(rs.getTimestamp("order_date"));
                    order.setTotalAmount(rs.getBigDecimal("total_amount"));
                    order.setPaymentMethod(rs.getString("payment_method"));
                    order.setPaymentStatus(rs.getString("payment_status"));
                    order.setOrderStatus(rs.getString("order_status"));
                    order.setDeliveryAddress(
                            rs.getString("delivery_address"));

                    List<OrderItem> orderItems = new ArrayList<>();

                    try (PreparedStatement itemPs =
                                 con.prepareStatement(itemSql)) {

                        itemPs.setLong(1, order.getOrderId());

                        try (ResultSet itemRs = itemPs.executeQuery()) {

                            while (itemRs.next()) {

                                OrderItem item = new OrderItem(
                                        itemRs.getString("product_id"),
                                        itemRs.getString("product_name"),
                                        itemRs.getInt("quantity"),
                                        itemRs.getBigDecimal("price"),
                                        itemRs.getString("product_image")
                                );

                                orderItems.add(item);
                            }
                        }
                    }

                    order.setItems(orderItems);
                    orders.add(order);
                }
            }
        }

        return orders;
    }

    public boolean cancelOrder(long orderId, String username)
            throws SQLException {

        if (username == null || username.trim().isEmpty()) {
            throw new IllegalArgumentException("Please log in first.");
        }

        try (Connection con = DBConnection.getConnection()) {

            con.setAutoCommit(false);

            try {
                // 1. Lock the order and verify its owner.
                String checkSql =
                        "SELECT order_status FROM orders " +
                                "WHERE order_id = ? AND user_name = ? FOR UPDATE";

                String orderStatus;

                try (PreparedStatement ps =
                             con.prepareStatement(checkSql)) {

                    ps.setLong(1, orderId);
                    ps.setString(2, username);

                    try (ResultSet rs = ps.executeQuery()) {
                        if (!rs.next()) {
                            throw new IllegalArgumentException(
                                    "Order not found.");
                        }

                        orderStatus = rs.getString("order_status");
                    }
                }

                // 2. Only Pending orders can be cancelled.
                if (orderStatus == null ||
                        !"Pending".equalsIgnoreCase(orderStatus.trim())) {

                    throw new IllegalStateException(
                            "This order cannot be cancelled. " +
                                    "Only Pending orders can be cancelled.");
                }

                // 3. Read the ordered products.
                String itemsSql =
                        "SELECT product_id, quantity " +
                                "FROM order_items WHERE order_id = ?";

                List<String> productIds = new ArrayList<>();
                List<Integer> quantities = new ArrayList<>();

                try (PreparedStatement ps =
                             con.prepareStatement(itemsSql)) {

                    ps.setLong(1, orderId);

                    try (ResultSet rs = ps.executeQuery()) {
                        while (rs.next()) {
                            productIds.add(rs.getString("product_id"));
                            quantities.add(rs.getInt("quantity"));
                        }
                    }
                }

                if (productIds.isEmpty()) {
                    throw new IllegalStateException(
                            "No order items found. Cancellation was not completed.");
                }

                // 4. Restore stock for products that still exist.
                String stockSql =
                        "UPDATE quickshop " +
                                "SET productQty = productQty + ? " +
                                "WHERE productId = ?";

                try (PreparedStatement ps =
                             con.prepareStatement(stockSql)) {

                    for (int i = 0; i < productIds.size(); i++) {

                        int quantity = quantities.get(i);

                        if (quantity <= 0) {
                            throw new IllegalStateException(
                                    "Invalid order quantity.");
                        }

                        ps.setInt(1, quantity);
                        ps.setString(2, productIds.get(i));
                        ps.executeUpdate();
                    }
                }

                // 5. Mark the order as Cancelled.
                String updateSql =
                        "UPDATE orders SET order_status = 'Cancelled' " +
                                "WHERE order_id = ? AND user_name = ? " +
                                "AND LOWER(TRIM(order_status)) = 'pending'";

                try (PreparedStatement ps =
                             con.prepareStatement(updateSql)) {

                    ps.setLong(1, orderId);
                    ps.setString(2, username);

                    if (ps.executeUpdate() != 1) {
                        throw new IllegalStateException(
                                "Order cancellation failed. Please try again.");
                    }
                }

                // 6. Commit the stock and order changes together.
                con.commit();
                return true;

            } catch (Exception e) {

                try {
                    con.rollback();
                } catch (SQLException rollbackError) {
                    e.addSuppressed(rollbackError);
                }

                if (e instanceof SQLException) {
                    throw (SQLException) e;
                }

                throw new IllegalStateException(
                        e.getMessage(), e);

            } finally {
                try {
                    con.setAutoCommit(true);
                } catch (SQLException ignored) {
                    // Connection will close automatically.
                }
            }
        }
    }
}
