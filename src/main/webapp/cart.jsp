<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.entity.Cart_Item" %>

<%
String username = (String) session.getAttribute("username");

if (username == null) {
    response.sendRedirect("login.jsp");
    return;
}

List<Cart_Item> cartList =
        (List<Cart_Item>) request.getAttribute("cartList");

double grandTotal = 0;

if (cartList == null) {
    cartList = new java.util.ArrayList<>();
}
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Shopping Cart | QuickShop</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
          rel="stylesheet">

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            background: #EAEDED;
            font-family: Arial, sans-serif;
            color: #0F1111;
        }

        .top-header {
            background: #131921;
            color: white;
            padding: 15px 25px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
            flex-wrap: wrap;
        }

        .brand {
            color: #FF9900;
            font-size: 27px;
            font-weight: bold;
            text-decoration: none;
        }

        .header-link {
            color: white;
            text-decoration: none;
            font-size: 14px;
        }

        .header-link:hover {
            color: #FF9900;
        }

        .page-container {
            max-width: 1400px;
            margin: 25px auto;
            padding: 0 18px;
        }

        .cart-heading {
            background: white;
            padding: 22px;
            margin-bottom: 20px;
            border-radius: 4px;
        }

        .cart-heading h2 {
            font-size: 27px;
            margin: 0 0 8px;
        }

        .cart-layout {
            display: grid;
            grid-template-columns: minmax(0, 1fr) 300px;
            gap: 20px;
            align-items: start;
        }

        .cart-products {
            background: white;
            padding: 20px;
            border-radius: 4px;
        }

        .cart-item {
            display: flex;
            gap: 20px;
            padding: 22px 0;
            border-bottom: 1px solid #DDD;
        }

        .cart-item:first-child {
            padding-top: 5px;
        }

        .product-image {
            width: 150px;
            height: 150px;
            object-fit: contain;
            flex-shrink: 0;
        }

        .product-details {
            flex: 1;
            min-width: 0;
        }

        .product-name {
            font-size: 19px;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .product-price {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .stock-text {
            color: #007600;
            font-size: 14px;
            margin-bottom: 12px;
        }

        .quantity-text {
            font-size: 14px;
            margin-bottom: 8px;
        }

        /* Quantity + and - buttons */
        .quantity-controls {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-top: 8px;
            margin-bottom: 8px;
        }

        .quantity-controls form {
            margin: 0;
        }

        .quantity-btn {
            width: 32px;
            height: 32px;
            border: 1px solid #CCC;
            border-radius: 50%;
            background: #FFF;
            color: #111;
            cursor: pointer;
            font-size: 17px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .quantity-btn:hover {
            background: #F7CA00;
        }

        .quantity-btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        .quantity-number {
            min-width: 22px;
            text-align: center;
            font-weight: bold;
        }

        .item-subtotal {
            margin-top: 8px;
            font-weight: bold;
        }

        .delete-form {
            margin-top: 12px;
        }

        .delete-btn {
            background: white;
            color: #B12704;
            border: 1px solid #CCC;
            border-radius: 5px;
            padding: 7px 14px;
            cursor: pointer;
            font-size: 14px;
        }

        .delete-btn:hover {
            background: #FFF0F0;
            border-color: #B12704;
        }

        .summary-card {
            background: white;
            padding: 22px;
            border-radius: 4px;
            position: sticky;
            top: 20px;
        }

        .summary-card h4 {
            font-size: 21px;
            margin-bottom: 20px;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            gap: 12px;
            margin-bottom: 15px;
            font-size: 15px;
        }

        .grand-total {
            border-top: 1px solid #DDD;
            padding-top: 15px;
            font-size: 19px;
            font-weight: bold;
            color: #B12704;
        }

        .checkout-btn {
            width: 100%;
            border: none;
            border-radius: 20px;
            background: #FFD814;
            padding: 11px;
            font-size: 15px;
            margin-top: 12px;
            cursor: pointer;
        }

        .checkout-btn:hover {
            background: #F7CA00;
        }

        .continue-btn {
            display: inline-block;
            background: #FFD814;
            color: #111;
            padding: 10px 18px;
            border-radius: 20px;
            text-decoration: none;
            font-size: 14px;
            margin-top: 15px;
        }

        .continue-btn:hover {
            background: #F7CA00;
            color: #111;
        }

        .empty-cart {
            background: white;
            text-align: center;
            padding: 60px 20px;
            border-radius: 4px;
        }

        .empty-cart i {
            font-size: 65px;
            color: #777;
        }

        .empty-cart h3 {
            margin-top: 18px;
        }

        .footer {
            background: #232F3E;
            color: white;
            text-align: center;
            padding: 22px;
            margin-top: 35px;
            font-size: 14px;
        }

        @media (max-width: 850px) {
            .cart-layout {
                grid-template-columns: 1fr;
            }

            .summary-card {
                position: static;
            }
        }

        @media (max-width: 500px) {
            .cart-item {
                gap: 12px;
                flex-direction: column;
            }

            .product-image {
                width: 100%;
                height: 180px;
            }

            .cart-heading h2 {
                font-size: 23px;
            }
        }
    </style>
</head>

<body>

<header class="top-header">

    <a href="userViewAllProduct" class="brand">
        <i class="bi bi-shop"></i> QuickShop
    </a>

    <span>
        <i class="bi bi-person-circle"></i>
        Hello, <%= username %>
    </span>

    <a href="userViewAllProduct" class="header-link">
        <i class="bi bi-arrow-left"></i> Continue Shopping
    </a>

</header>

<main class="page-container">

    <div class="cart-heading">
        <h2>Shopping Cart</h2>

        <span class="text-secondary">
            <%= cartList.size() %> item(s) in your cart
        </span>
    </div>

    <%-- Display messages from UpdateCartServlet --%>
    <%
        String cartMessage =
                (String) session.getAttribute("cartMessage");

        if (cartMessage != null) {
    %>

        <div class="alert alert-warning alert-dismissible fade show"
             role="alert">

            <%= cartMessage %>

            <button type="button"
                    class="btn-close"
                    data-bs-dismiss="alert"
                    aria-label="Close">
            </button>

        </div>

    <%
            session.removeAttribute("cartMessage");
        }
    %>

    <% if (cartList.isEmpty()) { %>

        <div class="empty-cart">

            <i class="bi bi-cart3"></i>

            <h3>Your QuickShop cart is empty</h3>

            <p class="text-secondary">
                Looks like you haven't added anything to your cart yet.
            </p>

            <a href="userViewAllProduct" class="continue-btn">
                <i class="bi bi-bag"></i> Start Shopping
            </a>

        </div>

    <% } else { %>

        <div class="cart-layout">

            <section class="cart-products">

                <% for (Cart_Item item : cartList) {

                    double subtotal =
                            item.getProductPrice() * item.getQuantity();

                    grandTotal += subtotal;

                    String imagePath = item.getImage();

                    if (imagePath == null || imagePath.trim().isEmpty()) {

                        imagePath =
                                "https://placehold.co/150x150?text=No+Image";

                    } else if (!imagePath.startsWith("http://")
                            && !imagePath.startsWith("https://")) {

                        imagePath = request.getContextPath()
                                + "/images/" + imagePath;
                    }
                %>

                    <div class="cart-item">

                        <img src="<%= imagePath %>"
                             alt="Product image"
                             class="product-image"
                             onerror="this.onerror=null;this.src='https://placehold.co/150x150?text=No+Image';">

                        <div class="product-details">

                            <div class="product-name">
                                <%= item.getProductName() %>
                            </div>

                            <div class="product-price">
                                ₹<%= String.format("%.2f",
                                        item.getProductPrice()) %>
                            </div>

                            <div class="stock-text">
                                <i class="bi bi-check-circle"></i>
                                In your cart
                            </div>

                            <%-- Quantity controls --%>
                            <div class="quantity-text">

                                <strong>Quantity:</strong>

                                <div class="quantity-controls">

                                    <%-- Decrease quantity --%>
                                    <form action="updateCart" method="post">

                                        <input type="hidden"
                                               name="productId"
                                               value="<%= item.getProductId() %>">

                                        <input type="hidden"
                                               name="action"
                                               value="decrease">

                                        <button type="submit"
                                                class="quantity-btn"
                                                aria-label="Decrease quantity">

                                            <i class="bi bi-dash"></i>

                                        </button>

                                    </form>

                                    <span class="quantity-number">
                                        <%= item.getQuantity() %>
                                    </span>

                                    <%-- Increase quantity --%>
                                    <form action="updateCart" method="post">

                                        <input type="hidden"
                                               name="productId"
                                               value="<%= item.getProductId() %>">

                                        <input type="hidden"
                                               name="action"
                                               value="increase">

                                        <button type="submit"
                                                class="quantity-btn"
                                                aria-label="Increase quantity"
                                                <%= item.getQuantity()
                                                        >= item.getAvailableQty()
                                                        ? "disabled" : "" %>>

                                            <i class="bi bi-plus"></i>

                                        </button>

                                    </form>

                                </div>

                                <small class="text-secondary">
                                    Available stock:
                                    <%= item.getAvailableQty() %>
                                </small>

                            </div>

                            <div class="item-subtotal">
                                Subtotal:
                                ₹<%= String.format("%.2f", subtotal) %>
                            </div>

                            <%-- Delete product form --%>
                            <form action="deleteCart"
                                  method="get"
                                  class="delete-form"
                                  onsubmit="return confirm('Are you sure you want to remove this product from your cart?');">

                                <input type="hidden"
                                       name="productId"
                                       value="<%= item.getProductId() %>">

                                <button type="submit" class="delete-btn">

                                    <i class="bi bi-trash"></i>
                                    Delete

                                </button>

                            </form>

                        </div>

                    </div>

                <% } %>

                <div class="text-end mt-4">

                    <strong>
                        Total:
                        ₹<%= String.format("%.2f", grandTotal) %>
                    </strong>

                </div>

            </section>

            <aside class="summary-card">

                <h4>Order Summary</h4>

                <div class="summary-row">
                    <span>Items</span>
                    <span><%= cartList.size() %></span>
                </div>

                <div class="summary-row">
                    <span>Delivery</span>
                    <span class="text-success">FREE</span>
                </div>

                <div class="summary-row grand-total">

                    <span>Total</span>

                    <span>
                        ₹<%= String.format("%.2f", grandTotal) %>
                    </span>

                </div>

                <button type="button"
                        class="checkout-btn"
                        onclick="alert('Checkout will be developed in the next step.');">

                    Proceed to Checkout

                </button>

                <a href="userViewAllProduct"
                   class="continue-btn w-100 text-center">

                    Continue Shopping

                </a>

            </aside>

        </div>

    <% } %>

</main>

<footer class="footer">
    © 2026 QuickShop | Your Online Shopping Store
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
