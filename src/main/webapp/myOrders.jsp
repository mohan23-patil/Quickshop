
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="com.entity.Order" %>
<%@ page import="com.entity.OrderItem" %>

<%!
    private String esc(Object value) {
        if (value == null) return "";
        return value.toString()
                .replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#39;");
    }

    private String money(BigDecimal amount) {
        if (amount == null) amount = BigDecimal.ZERO;

        NumberFormat format =
                NumberFormat.getNumberInstance(new Locale("en", "IN"));

        format.setMinimumFractionDigits(2);
        format.setMaximumFractionDigits(2);

        return "₹" + format.format(amount);
    }

    private String dateText(Object value) {
        if (value == null) return "Date unavailable";

        if (value instanceof java.util.Date) {
            return new SimpleDateFormat(
                    "dd MMM yyyy, hh:mm a",
                    Locale.ENGLISH
            ).format((java.util.Date) value);
        }

        return esc(value);
    }

    private String safeStatus(String value) {
        if (value == null || value.trim().isEmpty()) {
            return "Processing";
        }

        return value.trim();
    }
%>

<%
    String username = (String) session.getAttribute("username");

    if (username == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    List<Order> orders =
            (List<Order>) request.getAttribute("orders");

    if (orders == null) {
        orders = Collections.emptyList();
    }

    String placed = (String) request.getAttribute("placed");
    String newOrderId = (String) request.getAttribute("newOrderId");
    String searchTerm = (String) request.getAttribute("searchTerm");

    if (searchTerm == null) {
        searchTerm = "";
    }

    String ctx = request.getContextPath();

    String cancelled = request.getParameter("cancelled");
    String cancelError = request.getParameter("cancelError");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Quick Shop - Your Orders</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"
          rel="stylesheet">

    <style>
        :root {
            --qs-dark-navy: #131921;
            --qs-sub-nav: #232f3e;
            --qs-btn-yellow: #ffd814;
            --qs-btn-orange: #ffa41c;
            --qs-search-amber: #febd69;
            --qs-link-blue: #007185;
            --qs-link-hover: #c7511f;
            --qs-bg-canvas: #eaeded;
            --qs-border-color: #d5d9d9;
        }

        body {
            background: var(--qs-bg-canvas);
            color: #0f1111;
            font-family: "Segoe UI", system-ui, sans-serif;
            margin: 0;
            overflow-x: hidden;
        }

        .qs-main-header {
            background: var(--qs-dark-navy);
            color: white;
            padding: .5rem 1rem;
        }

        .qs-nav-box {
            border: 1px solid transparent;
            padding: 5px 9px;
            border-radius: 3px;
            display: inline-flex;
            flex-direction: column;
            justify-content: center;
            text-decoration: none;
            color: white;
        }

        .qs-nav-box:hover {
            border-color: white;
            color: white;
        }

        .qs-brand-logo {
            font-size: 1.45rem;
            font-weight: 800;
            display: flex;
            align-items: center;
            gap: 4px;
        }

        .qs-brand-smile {
            color: var(--qs-search-amber);
        }

        .qs-search-container {
            max-width: 880px;
        }

        .qs-search-dropdown {
            background: #e6e6e6;
            border: 0;
            font-size: .85rem;
            max-width: 135px;
        }

        .qs-search-input {
            border: 0;
            font-size: .95rem;
            padding: 10px 14px;
        }

        .qs-search-input:focus {
            outline: 2px solid var(--qs-search-amber);
            box-shadow: none;
        }

        .qs-search-btn {
            background: var(--qs-search-amber);
            border: 0;
        }

        .qs-search-btn:hover {
            background: #f3a847;
        }

        .qs-sub-navbar {
            background: var(--qs-sub-nav);
            padding: 0 1rem;
            min-height: 42px;
        }

        .qs-sub-nav-item {
            color: white;
            font-size: .88rem;
            padding: 6px 10px;
            text-decoration: none;
            white-space: nowrap;
            border: 1px solid transparent;
        }

        .qs-sub-nav-item:hover {
            border-color: white;
            color: white;
        }

        .qs-confirm-banner,
        .qs-order-card {
            background: white;
            border: 1px solid var(--qs-border-color);
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(19, 25, 33, .06);
        }

        .qs-order-card {
            overflow: hidden;
            margin-bottom: 1.5rem;
        }

        .qs-order-header {
            background: #f0f2f2;
            border-bottom: 1px solid var(--qs-border-color);
            padding: .85rem 1.25rem;
            font-size: .78rem;
        }

        .qs-btn-secondary-flat {
            background: white;
            border: 1px solid var(--qs-border-color);
            border-radius: 20px;
            color: #0f1111;
            font-size: .84rem;
            font-weight: 500;
            padding: .4rem 1rem;
            text-align: center;
            text-decoration: none;
            display: inline-block;
        }

        .qs-btn-secondary-flat:hover {
            background: #f7fafa;
            color: #0f1111;
        }

        .qs-btn-buynow {
            background: var(--qs-btn-orange);
            border: 1px solid #ff8f00;
            border-radius: 20px;
            color: #0f1111;
            font-size: .86rem;
            padding: .4rem 1rem;
            text-decoration: none;
            display: inline-block;
        }

        .qs-btn-buynow:hover {
            background: #fa8900;
            color: #0f1111;
        }

        .qs-item-icon {
            width: 90px;
            height: 90px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #f8f9fa;
            border: 1px solid #e7e7e7;
            border-radius: 4px;
            flex-shrink: 0;
            color: #6c757d;
            font-size: 2rem;
            overflow: hidden;
        }

        .qs-item-icon img {
            max-width: 100%;
            max-height: 100%;
            object-fit: contain;
        }

        .status-pill {
            display: inline-block;
            padding: .3rem .65rem;
            border-radius: 20px;
            background: #fff3cd;
            color: #664d03;
            font-size: .8rem;
            font-weight: 700;
            border: 1px solid #ffecb5;
        }

        .qs-back-to-top {
            background: #37475a;
            color: white;
            text-align: center;
            padding: 13px 0;
            font-size: .85rem;
            text-decoration: none;
            display: block;
        }

        .qs-back-to-top:hover {
            background: #485769;
            color: white;
        }

        .qs-footer-bottom {
            background: var(--qs-dark-navy);
            color: #999;
            padding: 24px 0;
            font-size: .75rem;
            text-align: center;
        }

        .empty-state {
            background: white;
            border: 1px solid var(--qs-border-color);
            border-radius: 8px;
            padding: 3rem 1rem;
            text-align: center;
        }

        @media(max-width: 767px) {
            .qs-main-header .row {
                justify-content: center;
            }

            .qs-search-container {
                min-width: 100%;
                margin: .4rem 0;
            }

            .qs-order-header {
                font-size: .75rem;
            }

            .qs-item-icon {
                width: 70px;
                height: 70px;
            }
        }

        @media print {
            header,
            footer,
            .no-print {
                display: none !important;
            }

            body {
                background: white;
            }

            .qs-order-card,
            .qs-confirm-banner {
                box-shadow: none;
                break-inside: avoid;
            }
        }
    </style>
</head>

<body>

<!-- HEADER -->
<header>
    <div class="qs-main-header">
        <div class="container-fluid px-lg-3">
            <div class="row align-items-center g-2">

                <div class="col-auto">
                    <a class="qs-nav-box"
                       href="<%= ctx %>/userViewAllProduct">

                        <span class="qs-brand-logo">
                            <i class="bi bi-cart3 text-warning"></i>
                            <span>Quick<span class="qs-brand-smile">Shop</span></span>
                        </span>
                    </a>
                </div>

                <div class="col">
                    <div class="qs-search-container mx-auto">
                        <form action="<%= ctx %>/userViewAllProduct"
                              class="input-group"
                              method="get">

                            <select class="form-select qs-search-dropdown"
                                    aria-label="Department filter"
                                    name="category">
                                <option value="">All</option>
                                <option value="electronics">Electronics</option>
                                <option value="computers">Computers</option>
                                <option value="home & kitchen">Home &amp; Kitchen</option>
                                <option value="clothes">Fashion</option>
                                <option value="books">Books</option>
                            </select>

                            <input class="form-control qs-search-input"
                                   name="search"
                                   placeholder="Search QuickShop products..."
                                   aria-label="Search products">

                            <button class="btn qs-search-btn" type="submit">
                                <i class="bi bi-search text-dark fs-5"></i>
                            </button>
                        </form>
                    </div>
                </div>

                <div class="col-auto d-flex align-items-center gap-1">
                    <a class="qs-nav-box" href="<%= ctx %>/userDashboard.jsp">
                        <span style="font-size:.72rem;color:#ccc">
                            Hello, <%= esc(username) %>
                        </span>
                        <span style="font-size:.85rem;font-weight:700">
                            Account &amp; Lists
                        </span>
                    </a>

                    <a class="qs-nav-box" href="<%= ctx %>/myOrders">
                        <span style="font-size:.72rem;color:#ccc">Returns</span>
                        <span style="font-size:.85rem;font-weight:700">
                            &amp; Orders
                        </span>
                    </a>

                    <a class="qs-nav-box" href="<%= ctx %>/viewCart">
                        <div class="d-flex align-items-center">
                            <i class="bi bi-cart2 fs-3 text-warning"></i>
                            <span class="fw-bold ms-2 mt-2">Cart</span>
                        </div>
                    </a>
                </div>

            </div>
        </div>
    </div>

    <nav class="qs-sub-navbar d-flex align-items-center overflow-x-auto">
        <a class="qs-sub-nav-item fw-bold"
           href="<%= ctx %>/userViewAllProduct">
            <i class="bi bi-list fs-5 me-1"></i> All
        </a>

        <a class="qs-sub-nav-item" href="<%= ctx %>/userViewAllProduct">
            Today's Deals
        </a>

        <a class="qs-sub-nav-item"
           href="<%= ctx %>/userViewAllProduct?category=electronics">
            Electronics
        </a>

        <a class="qs-sub-nav-item"
           href="<%= ctx %>/userViewAllProduct?category=computers">
            Computers &amp; Tech
        </a>

        <a class="qs-sub-nav-item"
           href="<%= ctx %>/userViewAllProduct?category=home%20%26%20kitchen">
            Home &amp; Kitchen
        </a>

        <a class="qs-sub-nav-item"
           href="<%= ctx %>/userViewAllProduct?category=clothes">
            Fashion &amp; Apparel
        </a>

        <a class="qs-sub-nav-item" href="<%= ctx %>/myOrders">
            Your Orders
        </a>
    </nav>
</header>

<!-- MAIN CONTENT -->
<main class="container-fluid px-lg-4 py-4">

    <!-- CANCELLATION MESSAGE -->
    <% if ("1".equals(cancelled)) { %>
        <div class="alert alert-success alert-dismissible fade show"
             role="alert">
            <i class="bi bi-check-circle-fill me-2"></i>
            Your order has been cancelled successfully.
            <button type="button" class="btn-close"
                    data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <% } %>

    <% if ("1".equals(cancelError)) { %>
        <div class="alert alert-danger alert-dismissible fade show"
             role="alert">
            <i class="bi bi-exclamation-triangle-fill me-2"></i>
            Unable to cancel the order. It may already be processed,
            or an error occurred. Please refresh and check the order status.
            <button type="button" class="btn-close"
                    data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <% } %>

    <!-- SUCCESS MESSAGE AFTER ORDER PLACEMENT -->
    <% if ("1".equals(placed)) { %>

        <section class="qs-confirm-banner p-3 p-md-4 mb-4">
            <div class="d-flex align-items-start gap-3">

                <i class="bi bi-check-circle-fill text-success"
                   style="font-size:2.4rem"></i>

                <div class="flex-grow-1">
                    <h1 class="h4 fw-bold mb-1">
                        Order placed successfully!
                    </h1>

                    <p class="text-muted mb-2">
                        Thank you for shopping with QuickShop,
                        <strong><%= esc(username) %></strong>.
                    </p>

                    <% if (newOrderId != null && !newOrderId.isEmpty()) { %>
                        <p class="mb-3">
                            Your order number is
                            <strong>#<%= esc(newOrderId) %></strong>.
                        </p>
                    <% } %>

                    <div class="d-flex flex-wrap gap-2 no-print">
                        <button class="qs-btn-secondary-flat"
                                onclick="window.print()"
                                type="button">
                            <i class="bi bi-printer me-1"></i>
                            Print order
                        </button>

                        <a class="qs-btn-secondary-flat"
                           href="<%= ctx %>/userViewAllProduct">
                            <i class="bi bi-arrow-left me-1"></i>
                            Continue shopping
                        </a>
                    </div>
                </div>
            </div>
        </section>

    <% } %>

    <!-- ORDER TITLE AND SEARCH -->
    <div class="d-flex flex-column flex-md-row
                justify-content-between align-items-md-center
                gap-3 mb-3">

        <div>
            <h1 class="h3 fw-bold mb-1">Your Orders</h1>
            <p class="text-muted mb-0">
                View your order history and order details.
            </p>
        </div>

        <form class="d-flex no-print"
              action="<%= ctx %>/myOrders"
              method="get"
              role="search"
              style="max-width:420px;width:100%">

            <div class="input-group">
                <span class="input-group-text bg-white border-end-0 text-muted">
                    <i class="bi bi-search"></i>
                </span>

                <input class="form-control border-start-0 ps-0"
                       type="text"
                       name="search"
                       value="<%= esc(searchTerm) %>"
                       placeholder="Search order ID, product, status"
                       aria-label="Search all orders">

                <button class="btn btn-dark px-3"
                        style="background:#37475a;border-color:#37475a"
                        type="submit">
                    Search Orders
                </button>
            </div>
        </form>
    </div>

    <!-- NO ORDERS -->
    <% if (orders.isEmpty()) { %>

        <div class="empty-state my-4">
            <i class="bi bi-box-seam text-secondary"
               style="font-size:3rem"></i>

            <h2 class="h5 fw-bold mt-3">No orders found</h2>

            <% if (!searchTerm.isEmpty()) { %>

                <p class="text-muted">
                    No orders match “<%= esc(searchTerm) %>”.
                    Try another search.
                </p>

                <a class="qs-btn-secondary-flat"
                   href="<%= ctx %>/myOrders">
                    Clear search
                </a>

            <% } else { %>

                <p class="text-muted">
                    You haven't placed any orders yet.
                </p>

                <a class="qs-btn-buynow"
                   href="<%= ctx %>/userViewAllProduct">
                    Start shopping
                </a>

            <% } %>
        </div>

    <% } else { %>

        <!-- DISPLAY ORDERS FROM DATABASE -->
        <% for (Order order : orders) { %>

            <section class="qs-order-card">

                <!-- ORDER HEADER -->
                <div class="qs-order-header">
                    <div class="row align-items-start g-3">

                        <div class="col-6 col-md-3">
                            <div class="text-muted text-uppercase fw-bold mb-1"
                                 style="font-size:.68rem;letter-spacing:.5px">
                                ORDER PLACED
                            </div>

                            <div class="fw-semibold text-dark">
                                <%= dateText(order.getOrderDate()) %>
                            </div>
                        </div>

                        <div class="col-6 col-md-2">
                            <div class="text-muted text-uppercase fw-bold mb-1"
                                 style="font-size:.68rem;letter-spacing:.5px">
                                TOTAL
                            </div>

                            <div class="fw-semibold text-dark">
                                <%= money(order.getTotalAmount()) %>
                            </div>
                        </div>

                        <div class="col-6 col-md-3">
                            <div class="text-muted text-uppercase fw-bold mb-1"
                                 style="font-size:.68rem;letter-spacing:.5px">
                                ORDER NUMBER
                            </div>

                            <div class="fw-semibold text-dark">
                                #<%= esc(order.getOrderId()) %>
                            </div>
                        </div>

                        <div class="col-6 col-md-4">
                            <div class="text-muted text-uppercase fw-bold mb-1"
                                 style="font-size:.68rem;letter-spacing:.5px">
                                SHIP TO
                            </div>

                            <div class="fw-semibold text-dark">
                                <%= esc(order.getUserName()) %>
                            </div>

                            <div class="text-muted">
                                <%= esc(order.getDeliveryAddress()) %>
                            </div>
                        </div>

                    </div>
                </div>

                <!-- ORDER BODY -->
                <div class="p-3 p-md-4">
                    <div class="row g-4">

                        <!-- PRODUCT ITEMS -->
                        <div class="col-lg-8">

                            <div class="d-flex flex-wrap align-items-center gap-2 mb-3">

                                <span class="status-pill">
                                    <%= esc(safeStatus(order.getOrderStatus())) %>
                                </span>

                                <span class="text-muted small">
                                    Payment:
                                    <strong>
                                        <%= esc(safeStatus(order.getPaymentStatus())) %>
                                    </strong>
                                </span>

                                <% if ("Pending".equalsIgnoreCase(
                                        safeStatus(order.getOrderStatus()).trim())) { %>

                                    <form method="post"
                                          action="<%= ctx %>/cancelOrder"
                                          class="ms-md-auto no-print"
                                          onsubmit="return confirm('Are you sure you want to cancel this order?');">

                                        <input type="hidden"
                                               name="orderId"
                                               value="<%= order.getOrderId() %>">

                                        <button type="submit"
                                                class="btn btn-outline-danger btn-sm rounded-pill px-3">
                                            <i class="bi bi-x-circle me-1"></i>
                                            Cancel Order
                                        </button>
                                    </form>

                                <% } %>

                            </div>

                            <% if (order.getItems() != null
                                    && !order.getItems().isEmpty()) { %>

                                <% for (OrderItem item : order.getItems()) { %>

                                    <div class="d-flex gap-3 pb-3 mb-3 border-bottom">

                                        <div class="qs-item-icon">
                                            <%
                                                String imageUrl = item.getImage();

                                                if (imageUrl != null &&
                                                        !imageUrl.trim().isEmpty()) {
                                            %>
                                                <img
                                                    src="<%= esc(imageUrl) %>"
                                                    alt="<%= esc(item.getProductName()) %>"
                                                    loading="lazy"
                                                    onerror="this.onerror=null; this.style.display='none';">
                                            <%
                                                } else {
                                            %>
                                                <i class="bi bi-box-seam"></i>
                                            <%
                                                }
                                            %>
                                        </div>

                                        <div class="flex-grow-1 min-w-0">

                                            <div class="fw-semibold text-dark mb-1"
                                                 style="font-size:.95rem;line-height:1.35">
                                                <%= esc(item.getProductName()) %>
                                            </div>

                                            <div class="text-muted small mb-2">
                                                Product ID:
                                                <%= esc(item.getProductId()) %>
                                            </div>

                                            <div class="d-flex flex-wrap align-items-center gap-2 mb-2">

                                                <span class="fw-bold">
                                                    <%= money(item.getPrice()) %>
                                                </span>

                                                <span class="badge bg-light text-secondary border">
                                                    Qty: <%= item.getQuantity() %>
                                                </span>

                                                <span class="text-muted small">
                                                    Subtotal:
                                                    <strong>
                                                        <%= money(item.getSubtotal()) %>
                                                    </strong>
                                                </span>

                                            </div>

                                            <a class="qs-btn-buynow py-1 px-3 no-print"
                                               href="<%= ctx %>/userViewAllProduct"
                                               style="font-size:.8rem">
                                                Continue shopping
                                            </a>

                                        </div>
                                    </div>

                                <% } %>

                            <% } else { %>

                                <p class="text-muted">
                                    No item details are available for this order.
                                </p>

                            <% } %>

                        </div>

                        <!-- ORDER SUMMARY -->
                        <div class="col-lg-4">
                            <div class="d-flex flex-column gap-2 ps-lg-3">

                                <div class="border rounded p-3">

                                    <div class="fw-bold mb-2">
                                        Order summary
                                    </div>

                                    <div class="d-flex justify-content-between gap-3 small mb-2">
                                        <span class="text-muted">Order ID</span>
                                        <span>#<%= esc(order.getOrderId()) %></span>
                                    </div>

                                    <div class="d-flex justify-content-between gap-3 small mb-2">
                                        <span class="text-muted">Payment method</span>
                                        <span><%= esc(order.getPaymentMethod()) %></span>
                                    </div>

                                    <div class="d-flex justify-content-between gap-3 small mb-2">
                                        <span class="text-muted">Payment status</span>
                                        <span><%= esc(safeStatus(order.getPaymentStatus())) %></span>
                                    </div>

                                    <hr>

                                    <div class="d-flex justify-content-between gap-3">
                                        <strong>Total</strong>
                                        <strong><%= money(order.getTotalAmount()) %></strong>
                                    </div>

                                </div>

                                <a class="qs-btn-secondary-flat no-print"
                                   href="<%= ctx %>/userViewAllProduct">
                                    Continue shopping
                                </a>

                            </div>
                        </div>

                    </div>
                </div>

            </section>

        <% } %>

    <% } %>

</main>

<!-- FOOTER -->
<footer>
    <a class="qs-back-to-top" href="#" id="backToTopBtn">
        Back to top
    </a>

    <div class="qs-footer-bottom">
        <div class="container">
            <p class="mb-0">
                © 2026 QuickShop.com dev - Mohan Patil.
            </p>
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    document.getElementById('backToTopBtn').addEventListener('click', function(e) {
        e.preventDefault();
        window.scrollTo({
            top: 0,
            behavior: 'smooth'
        });
    });
</script>

</body>
</html>
