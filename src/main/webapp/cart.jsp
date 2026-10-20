<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Locale" %>
<%@ page import="com.entity.Cart_Item" %>

<%
    String username = (String) session.getAttribute("username");

    if (username == null || username.trim().isEmpty()) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    List<Cart_Item> cartList =
            (List<Cart_Item>) request.getAttribute("cartList");

    if (cartList == null) {
        cartList = new ArrayList<Cart_Item>();
    }

    double grandTotal = 0.0;
    int totalItems = 0;

    for (Cart_Item item : cartList) {
        grandTotal += item.getProductPrice() * item.getQuantity();
        totalItems += item.getQuantity();
    }

    String cartMessage = (String) session.getAttribute("cartMessage");

    if (cartMessage != null) {
        session.removeAttribute("cartMessage");
    }

    String contextPath = request.getContextPath();

    String formattedGrandTotal =
            String.format(Locale.US, "%.2f", grandTotal);
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>QuickShop - Shopping Cart</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
          rel="stylesheet">

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
          rel="stylesheet">

    <style>
        :root {
            --qs-dark-navy: #131921;
            --qs-slate: #232f3e;
            --qs-yellow: #ffd814;
            --qs-yellow-hover: #f7ca00;
            --qs-orange: #ffa41c;
            --qs-bg-light: #eaeded;
            --qs-border: #d5d9d9;
            --qs-text: #0f1111;
            --qs-link: #007185;
            --qs-green: #007600;
            --qs-price-red: #b12704;
        }

        * {
            box-sizing: border-box;
        }

        body {
            background: var(--qs-bg-light);
            color: var(--qs-text);
            font-family: 'Inter', system-ui, sans-serif;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            overflow-x: hidden;
        }

        /* HEADER */

        .navbar-quickshop {
            background-color: var(--qs-dark-navy);
            padding: 0.65rem 1.25rem;
        }

        .logo-container {
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 4px;
            flex-shrink: 0;
        }

        .logo-text {
            color: #ffffff;
            font-weight: 800;
            font-size: 1.5rem;
            letter-spacing: -0.5px;
            white-space: nowrap;
        }

        .logo-text span {
            color: var(--qs-orange);
        }

        .nav-subline {
            font-size: 0.75rem;
            color: #cccccc;
            line-height: 1.3;
        }

        .nav-mainline {
            font-size: 0.875rem;
            font-weight: 700;
            color: #ffffff;
            line-height: 1.4;
        }

        .btn-continue-nav {
            background-color: #37475a;
            color: #ffffff;
            border: 1px solid #485769;
            font-weight: 600;
            font-size: 0.9rem;
            padding: 0.45rem 1.15rem;
            border-radius: 20px;
            transition: all 0.2s ease;
            white-space: nowrap;
            text-decoration: none;
        }

        .btn-continue-nav:hover {
            background-color: #485769;
            color: #ffffff;
            border-color: #ffffff;
        }

        /* SEARCH */

        .quickshop-search {
            flex: 1 1 400px;
            max-width: 550px;
            min-width: 0;
        }

        .quickshop-search .input-group {
            width: 100%;
            flex-wrap: nowrap;
        }

        .quickshop-search .form-control {
            min-width: 0;
        }

        .search-category {
            width: 125px;
            max-width: 145px;
            flex: 0 0 125px;
            background: #e6e6e6;
            font-size: 0.82rem;
            border: none;
        }

        .search-submit {
            background: var(--qs-orange);
            color: #111;
            border: none;
            min-width: 45px;
        }

        .search-submit:hover {
            background: #fa8900;
            color: #111;
        }

        /* MAIN LAYOUT */

        .cart-surface,
        .order-summary-box {
            background: #fff;
            border: 1px solid var(--qs-border);
            border-radius: 8px;
            padding: 24px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
        }

        .order-summary-box {
            position: sticky;
            top: 16px;
        }

        /* CART ITEMS */

        .item-card {
            border-top: 1px solid #e7e7e7;
            padding: 20px 0;
        }

        .item-card:first-child {
            border-top: none;
            padding-top: 8px;
        }

        .product-img-box {
            width: 130px;
            height: 130px;
            flex-shrink: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #f7f7f7;
            border: 1px solid #e2e5e5;
            border-radius: 6px;
            overflow: hidden;
        }

        .product-img-box img {
            width: 100%;
            height: 100%;
            padding: 5px;
            object-fit: contain;
        }

        .product-title {
            color: #0f1111;
            font-size: 1.05rem;
            font-weight: 600;
            line-height: 1.4;
            text-decoration: none;
            overflow-wrap: anywhere;
        }

        .product-title:hover {
            color: var(--qs-link);
            text-decoration: underline;
        }

        .in-stock-label {
            color: var(--qs-green);
            font-size: 0.8rem;
            font-weight: 600;
        }

        .price-tag {
            color: var(--qs-price-red);
            font-size: 1.2rem;
            font-weight: 700;
        }

        /* QUANTITY */

        .qty-stepper {
            display: inline-flex;
            align-items: center;
            background: #f0f2f2;
            border: 1px solid #d5d9d9;
            border-radius: 8px;
            overflow: hidden;
        }

        .qty-stepper form {
            display: flex;
        }

        .qty-btn {
            min-width: 38px;
            min-height: 36px;
            border: none;
            background: transparent;
            color: #0f1111;
            font-size: 1rem;
            font-weight: 700;
            cursor: pointer;
        }

        .qty-btn:hover:not(:disabled) {
            background: #e3e6e6;
        }

        .qty-btn:disabled {
            color: #999;
            cursor: not-allowed;
        }

        .qty-val {
            min-width: 35px;
            text-align: center;
            font-weight: 600;
            align-self: center;
        }

        .btn-delete-icon {
            border: 1px solid transparent;
            background: transparent;
            color: #565959;
            border-radius: 6px;
            padding: 6px 9px;
        }

        .btn-delete-icon:hover {
            color: #c40000;
            background: #fee;
            border-color: #f5c2c7;
        }

        .item-subtotal-badge {
            background: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 6px;
            padding: 7px 12px;
            font-size: 0.9rem;
            font-weight: 600;
            white-space: nowrap;
        }

        /* TOTALS */

        .final-total-container {
            background: #fbfbfb;
            border: 1px dashed #c0c6c6;
            border-radius: 8px;
            padding: 16px 20px;
        }

        .final-total-pill {
            display: inline-block;
            background: #e7f4f5;
            border: 1px solid #007185;
            color: #004b57;
            font-size: 1.1rem;
            font-weight: 700;
            padding: 8px 14px;
            border-radius: 6px;
        }

        .btn-primary-order {
            width: 100%;
            background: var(--qs-yellow);
            border: 1px solid #fcd200;
            border-radius: 100px;
            color: #0f1111;
            font-weight: 700;
            padding: 11px 16px;
        }

        .btn-primary-order:hover {
            background: var(--qs-yellow-hover);
            color: #0f1111;
        }

        .btn-primary-order:disabled {
            background: #e5e5e5;
            border-color: #d5d9d9;
            color: #777;
        }

        .btn-secondary-continue {
            width: 100%;
            background: #fff;
            border: 1px solid #d5d9d9;
            border-radius: 100px;
            color: #0f1111;
            font-weight: 600;
            padding: 10px 16px;
        }

        .btn-secondary-continue:hover {
            background: #f7fafa;
            color: #0f1111;
        }

        .summary-divider {
            border-top: 1px solid #d5d9d9;
            margin: 20px 0;
        }

        /* SEARCH EMPTY RESULT */

        #noCartSearchResult {
            display: none;
            text-align: center;
            background: #fff;
            padding: 30px 15px;
            border-radius: 8px;
            color: #565959;
        }

        #noCartSearchResult i {
            font-size: 2.5rem;
            color: #999;
        }

        /* FOOTER */

        .qs-footer {
            margin-top: auto;
            background: var(--qs-slate);
            color: #fff;
        }

        .back-to-top {
            display: block;
            background: #37475a;
            color: #fff;
            text-align: center;
            text-decoration: none;
            padding: 12px;
            font-size: 0.85rem;
            font-weight: 600;
        }

        .back-to-top:hover {
            background: #485769;
            color: #fff;
        }

        .footer-bottom {
            background: var(--qs-dark-navy);
            padding: 22px 10px;
            color: #aaa;
            font-size: 0.8rem;
            text-align: center;
        }

        /* TABLET */

        @media (max-width: 991.98px) {
            .cart-surface,
            .order-summary-box {
                padding: 20px;
            }

            .order-summary-box {
                position: static;
            }

            .product-img-box {
                width: 110px;
                height: 110px;
            }

            .navbar-quickshop .container-fluid {
                gap: 10px !important;
            }

            .quickshop-search {
                order: 3;
                flex: 1 1 100%;
                max-width: 100%;
                margin: 4px 0 0 !important;
            }
        }

        /* MOBILE */

        @media (max-width: 575.98px) {
            .navbar-quickshop {
                padding: 12px;
            }

            .logo-text {
                font-size: 1.3rem;
            }

            .btn-continue-nav {
                padding: 7px 10px;
                font-size: 0.75rem;
            }

            .user-session-block {
                display: none !important;
            }

            .quickshop-search {
                flex-basis: 100%;
                width: 100%;
            }

            .search-category {
                width: 95px;
                max-width: 95px;
                flex-basis: 95px;
                padding: 6px 4px;
                font-size: 0.72rem;
            }

            .quickshop-search input {
                font-size: 0.82rem;
                padding-left: 8px;
                padding-right: 5px;
            }

            .search-submit {
                min-width: 40px;
                padding: 7px 10px;
            }

            .cart-surface,
            .order-summary-box {
                padding: 15px;
            }

            .cart-surface h1 {
                font-size: 1.45rem;
            }

            .item-card {
                padding: 16px 0;
            }

            .product-img-box {
                width: 88px;
                height: 88px;
            }

            .product-title {
                font-size: 0.9rem;
            }

            .price-tag {
                font-size: 1rem;
            }

            .qty-btn {
                min-width: 32px;
                min-height: 32px;
            }

            .item-subtotal-badge {
                font-size: 0.8rem;
                padding: 6px 8px;
            }

            .final-total-container {
                padding: 13px;
            }

            .final-total-pill {
                font-size: 1rem;
            }
        }

        @media (max-width: 380px) {
            .navbar-quickshop {
                padding: 10px;
            }

            .logo-text {
                font-size: 1.1rem;
            }

            .btn-continue-nav {
                padding: 6px 8px;
                font-size: 0.7rem;
            }

            .product-img-box {
                width: 72px;
                height: 72px;
            }

            .cart-surface,
            .order-summary-box {
                padding: 12px;
            }

            .item-subtotal-badge {
                white-space: normal;
            }
        }
    </style>
</head>

<body>

<!-- ================= HEADER ================= -->

<header>
    <nav class="navbar navbar-quickshop"
         data-purpose="primary-navigation">

        <div class="container-fluid px-lg-4 d-flex align-items-center
                    justify-content-between flex-wrap gap-2">

            <!-- LOGO -->

            <a aria-label="QuickShop Home"
               class="logo-container"
               href="<%= contextPath %>/userViewAllProduct">

                <span class="logo-text">
                    <i class="bi bi-cart3 me-1 text-warning"></i>Quick<span>Shop</span>
                </span>
            </a>

            <!-- SEARCH AND CATEGORY
                 Search is handled by JavaScript on this page.
                 It does not call the missing search servlet. -->

            <form class="input-group quickshop-search mx-lg-3"
                  id="cartSearchForm"
                  role="search">

                <select class="form-select search-category"
                        id="cartCategorySelect"
                        aria-label="Select product category">

                    <option value="all">All Categories</option>
                    <option value="electronics">Electronics</option>
                    <option value="clothes">Clothes</option>
                    <option value="home">Home &amp; Kitchen</option>
                    <option value="computers">Computers &amp; Accessories</option>
                    <option value="books">Books</option>
                    <option value="sports">Sports</option>

                </select>

                <input class="form-control"
                       type="search"
                       id="cartSearchInput"
                       placeholder="Search cart items..."
                       aria-label="Search cart items">

                <button class="btn search-submit"
                        type="submit"
                        aria-label="Search">

                    <i class="bi bi-search"></i>
                </button>

            </form>

            <!-- SESSION USERNAME -->

            <div class="d-flex align-items-center gap-3">

                <div class="text-white text-end user-session-block">

                    <div class="nav-subline">
                        Hello,
                        <%= username.replace("&", "&amp;")
                                    .replace("<", "&lt;")
                                    .replace(">", "&gt;") %>
                    </div>

                    <div class="nav-mainline">
                        Account &amp; Lists
                        <i class="bi bi-caret-down-fill"
                           style="font-size:0.6rem;"></i>
                    </div>

                </div>

                <a class="btn btn-continue-nav"
                   href="<%= contextPath %>/userViewAllProduct">

                    <i class="bi bi-arrow-left me-1"></i>
                    <span class="d-none d-sm-inline">Continue Shopping</span>
                    <span class="d-sm-none">Shop</span>

                </a>

            </div>

        </div>
    </nav>
</header>

<!-- ================= MAIN CONTENT ================= -->

<main class="container-fluid px-3 px-lg-4 my-4 flex-grow-1">

    <% if (cartMessage != null && !cartMessage.trim().isEmpty()) { %>

        <div class="alert alert-warning alert-dismissible fade show"
             role="alert">

            <i class="bi bi-info-circle me-2"></i>
            <%= cartMessage %>

            <button type="button"
                    class="btn-close"
                    data-bs-dismiss="alert"
                    aria-label="Close">
            </button>
        </div>

    <% } %>

    <div class="row g-4">

        <!-- ========== CART ITEMS ========== -->

        <section class="col-lg-8"
                 aria-labelledby="shopping-cart-heading">

            <div class="cart-surface">

                <div class="d-flex justify-content-between
                            align-items-center border-bottom pb-3 mb-3">

                    <div>
                        <h1 class="h3 fw-bold mb-1"
                            id="shopping-cart-heading">
                            Shopping Cart
                        </h1>

                        <span class="text-muted small">
                            <%= totalItems %> item(s) in your cart
                        </span>
                    </div>

                    <i class="bi bi-cart3 fs-2 text-secondary"></i>
                </div>

                <% if (cartList.isEmpty()) { %>

                    <div class="text-center py-5">

                        <i class="bi bi-cart-x text-muted"
                           style="font-size: 4rem;"></i>

                        <h3 class="mt-3 fw-bold">
                            Your QuickShop Cart is empty
                        </h3>

                        <p class="text-muted">
                            Explore our products and find items you'll love.
                        </p>

                        <a class="btn btn-primary-order mt-2 d-inline-block"
                           style="max-width: 250px;"
                           href="<%= contextPath %>/userViewAllProduct">

                            <i class="bi bi-shop me-2"></i>
                            Continue Shopping
                        </a>

                    </div>

                <% } else { %>

                    <% for (Cart_Item item : cartList) {

                        String imagePath = item.getImage();

                        String imageUrl =
                                "https://placehold.co/150x150?text=No+Image";

                        if (imagePath != null && !imagePath.trim().isEmpty()) {

                            imagePath = imagePath.trim();

                            if (imagePath.startsWith("http://")
                                    || imagePath.startsWith("https://")) {

                                imageUrl = imagePath;

                            } else {

                                imageUrl = contextPath + "/images/" + imagePath;
                            }
                        }

                        double itemPrice = item.getProductPrice();
                        int quantity = item.getQuantity();
                        int availableQty = item.getAvailableQty();
                        double itemSubtotal = itemPrice * quantity;

                        String itemName = item.getProductName() == null
                                ? ""
                                : item.getProductName().trim();

                        /*
                         * Read category only if Cart_Item has a getCategory()
                         * method. This avoids a compilation error if your
                         * current Cart_Item class does not define that getter.
                         */
                        String itemCategory = "";

                        try {
                            Object categoryValue =
                                    item.getClass().getMethod("getCategory")
                                         .invoke(item);

                            if (categoryValue != null) {
                                itemCategory = categoryValue.toString();
                            }
                        } catch (Exception ignored) {
                            itemCategory = "";
                        }

                        String safeItemName =
                                itemName.replace("&", "&amp;")
                                        .replace("\"", "&quot;")
                                        .replace("<", "&lt;")
                                        .replace(">", "&gt;");

                        String safeItemCategory =
                                itemCategory.replace("&", "&amp;")
                                            .replace("\"", "&quot;")
                                            .replace("<", "&lt;")
                                            .replace(">", "&gt;");
                    %>

                    <article class="item-card cart-filter-item"
                             data-name="<%= safeItemName.toLowerCase(Locale.ROOT) %>"
                             data-category="<%= safeItemCategory %>">

                        <div class="d-flex gap-3 align-items-start">

                            <!-- PRODUCT IMAGE -->

                            <div class="product-img-box">

                                <img src="<%= imageUrl %>"
                                     alt="<%= safeItemName %>"
                                     loading="lazy"
                                     onerror="this.onerror=null;this.src='https://placehold.co/150x150?text=No+Image';">

                            </div>

                            <!-- PRODUCT DETAILS -->

                            <div class="flex-grow-1 min-w-0">

                                <div class="d-flex justify-content-between
                                            align-items-start gap-2">

                                    <div class="flex-grow-1">

                                        <span class="product-title d-block mb-2">
                                            <%= itemName %>
                                        </span>

                                        <% if (availableQty > 0) { %>

                                            <span class="in-stock-label d-block">
                                                <i class="bi bi-check-circle-fill me-1"></i>
                                                In Stock
                                            </span>

                                        <% } else { %>

                                            <span class="text-danger small fw-semibold">
                                                <i class="bi bi-exclamation-circle me-1"></i>
                                                Currently unavailable
                                            </span>

                                        <% } %>

                                    </div>

                                    <!-- DELETE ITEM -->

                                    <form action="<%= contextPath %>/deleteCart"
                                          method="get"
                                          onsubmit="return confirm('Remove this product from your cart?');">

                                        <input type="hidden"
                                               name="productId"
                                               value="<%= item.getProductId() %>">

                                        <button type="submit"
                                                class="btn-delete-icon"
                                                aria-label="Delete product"
                                                title="Remove item">

                                            <i class="bi bi-trash3-fill fs-5"></i>

                                        </button>

                                    </form>

                                </div>

                                <!-- PRICE AND QUANTITY -->

                                <div class="d-flex flex-wrap
                                            align-items-center
                                            justify-content-between
                                            gap-3 mt-3 pt-3 border-top">

                                    <div>
                                        <div class="text-muted small">
                                            Price
                                        </div>

                                        <div class="price-tag">
                                            ₹ <%= String.format(Locale.US, "%.2f", itemPrice) %>
                                        </div>
                                    </div>

                                    <!-- QUANTITY -->

                                    <div>

                                        <div class="text-muted small mb-1">
                                            Quantity
                                        </div>

                                        <div class="qty-stepper">

                                            <form action="<%= contextPath %>/updateCart"
                                                  method="post"
                                                  class="m-0">

                                                <input type="hidden"
                                                       name="productId"
                                                       value="<%= item.getProductId() %>">

                                                <input type="hidden"
                                                       name="action"
                                                       value="decrease">

                                                <button type="submit"
                                                        class="qty-btn"
                                                        aria-label="Decrease quantity"
                                                        <%= quantity <= 1 ? "disabled" : "" %>>

                                                    <i class="bi bi-dash"></i>

                                                </button>

                                            </form>

                                            <span class="qty-val">
                                                <%= quantity %>
                                            </span>

                                            <form action="<%= contextPath %>/updateCart"
                                                  method="post"
                                                  class="m-0">

                                                <input type="hidden"
                                                       name="productId"
                                                       value="<%= item.getProductId() %>">

                                                <input type="hidden"
                                                       name="action"
                                                       value="increase">

                                                <button type="submit"
                                                        class="qty-btn"
                                                        aria-label="Increase quantity"
                                                        <%= quantity >= availableQty ? "disabled" : "" %>>

                                                    <i class="bi bi-plus"></i>

                                                </button>

                                            </form>

                                        </div>

                                        <% if (quantity >= availableQty && availableQty > 0) { %>

                                            <small class="text-muted d-block mt-1">
                                                Stock limit reached
                                            </small>

                                        <% } %>

                                    </div>

                                    <!-- SUBTOTAL -->

                                    <div class="item-subtotal-badge">

                                        <span class="text-muted">Subtotal: </span>

                                        <strong>
                                            ₹ <%= String.format(Locale.US, "%.2f", itemSubtotal) %>
                                        </strong>

                                    </div>

                                </div>

                            </div>

                        </div>

                    </article>

                    <% } %>

                    <!-- NO SEARCH RESULTS -->

                    <div id="noCartSearchResult" class="mt-3">

                        <i class="bi bi-search"></i>

                        <h5 class="mt-3">
                            No matching cart items
                        </h5>

                        <p class="mb-0">
                            Try another product name or category.
                        </p>

                        <button type="button"
                                class="btn btn-outline-secondary btn-sm mt-3"
                                id="clearCartSearch">

                            Clear Search

                        </button>

                    </div>

                    <!-- CART TOTAL -->

                    <div class="final-total-container mt-3
                                d-flex flex-column flex-sm-row
                                justify-content-between
                                align-items-sm-center gap-3">

                        <div>
                            <span class="badge bg-success-subtle
                                         text-success-emphasis
                                         border border-success-subtle">

                                <i class="bi bi-truck me-1"></i>
                                Eligible for FREE Shipping

                            </span>

                            <p class="small text-muted mb-0 mt-2">
                                Delivery charges are free.
                            </p>
                        </div>

                        <div class="text-sm-end">

                            <div class="small text-muted mb-1">
                                Cart Total
                            </div>

                            <div class="final-total-pill">
                                ₹ <%= formattedGrandTotal %>
                            </div>

                        </div>

                    </div>

                <% } %>

            </div>

        </section>

        <!-- ========== ORDER SUMMARY ========== -->

        <aside class="col-lg-4"
               aria-labelledby="order-summary-heading">

            <div class="order-summary-box">

                <h2 class="h5 fw-bold mb-3 pb-3 border-bottom"
                    id="order-summary-heading">
                    Order Summary
                </h2>

                <div class="mb-3 p-3 rounded"
                     style="background-color:#f0fff4;border:1px solid #b7eb8f;">

                    <div class="d-flex align-items-center
                                text-success small fw-semibold">

                        <i class="bi bi-shield-check fs-5 me-2"></i>

                        Your order qualifies for FREE Delivery

                    </div>

                </div>

                <div class="d-flex justify-content-between
                            align-items-center mb-3">

                    <span class="text-muted">
                        Items (<%= totalItems %>)
                    </span>

                    <span class="fw-semibold">
                        ₹ <%= formattedGrandTotal %>
                    </span>

                </div>

                <div class="d-flex justify-content-between
                            align-items-center mb-3">

                    <span class="text-muted">
                        Delivery charge
                    </span>

                    <span class="text-success fw-bold">
                        FREE
                    </span>

                </div>

                <div class="d-flex justify-content-between
                            align-items-center mb-3 small">

                    <span class="text-muted">
                        Estimated tax
                    </span>

                    <span>
                        ₹ 0.00
                    </span>

                </div>

                <div class="summary-divider"></div>

                <div class="d-flex justify-content-between
                            align-items-baseline gap-2 mb-4">

                    <span class="fs-5 fw-bold">
                        Total Amount
                    </span>

                    <span class="fs-4 fw-bolder text-danger">
                        ₹ <%= formattedGrandTotal %>
                    </span>

                </div>

                <% if (cartList.isEmpty()) { %>

                    <button type="button"
                            class="btn btn-primary-order mb-2"
                            disabled>

                        <i class="bi bi-lock-fill me-2"></i>
                        Proceed to Checkout

                    </button>

                <% } else { %>

                    <button type="button"
                            class="btn btn-primary-order mb-2"
                            >

                        <a href="<%= request.getContextPath() %>/checkout">
                            Proceed to Checkout
                        </a>

                    </button>

                <% } %>

                <a class="btn btn-secondary-continue mb-3 d-block"
                   href="<%= contextPath %>/userViewAllProduct">

                    <i class="bi bi-arrow-left me-2"></i>
                    Continue Shopping

                </a>

                <div class="text-center mt-3 pt-3 border-top small text-muted">

                    <i class="bi bi-shield-lock me-1"></i>

                    <span style="font-size:0.75rem;">
                        Secure shopping with QuickShop
                    </span>

                </div>

            </div>

        </aside>

    </div>

</main>

<!-- ================= FOOTER ================= -->

<footer class="qs-footer">



    <div class="footer-bottom">

        <div class="container">

            <p class="mb-0">
                &copy; 2026 QuickShop.com - Developed by Mohan Patil.
            </p>

        </div>

    </div>

</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    const cartSearchForm =
        document.getElementById("cartSearchForm");

    const cartSearchInput =
        document.getElementById("cartSearchInput");

    const cartCategorySelect =
        document.getElementById("cartCategorySelect");

    const cartItems =
        document.querySelectorAll(".cart-filter-item");

    const noCartSearchResult =
        document.getElementById("noCartSearchResult");

    const clearCartSearch =
        document.getElementById("clearCartSearch");


    /*
     * Normalize category names using the same idea
     * as the User Dashboard.
     */
    function normalizeCategory(category) {
        category = (category || "")
            .trim()
            .toLowerCase()
            .replace(/\s+/g, " ");

        if (category === "electronic" ||
            category === "electronics") {
            return "electronics";
        }

        if (category === "clothes" ||
            category === "cloth" ||
            category === "fashion") {
            return "clothes";
        }

        if (category === "home" ||
            category === "home & kitchen" ||
            category === "home and kitchen") {
            return "home";
        }

        if (category === "computer" ||
            category === "computers" ||
            category === "computer & accessories" ||
            category === "computers & accessories" ||
            category === "computer accessories" ||
            category === "computers & acc." ||
            category === "computer & acc." ||
            category === "computers and accessories" ||
            category === "computer and accessories") {
            return "computers";
        }

        if (category === "book" || category === "books") {
            return "books";
        }

        if (category === "sport" || category === "sports") {
            return "sports";
        }

        return category;
    }


    /*
     * Filter the cart items by product name and category.
     */
    function filterCartItems() {
        const searchText =
            cartSearchInput.value.trim().toLowerCase();

        const selectedCategory =
            normalizeCategory(cartCategorySelect.value);

        let visibleItems = 0;

        cartItems.forEach(function(item) {
            const productName =
                (item.dataset.name || "").toLowerCase();

            const productCategory =
                normalizeCategory(item.dataset.category || "");

            const nameMatches =
                productName.includes(searchText);

            /*
             * If the Cart_Item object does not provide a category,
             * don't hide the item based on category alone.
             * See the note below about category support.
             */
            const categoryMatches =
                selectedCategory === "all" ||
                productCategory === "" ||
                productCategory === selectedCategory;

            const showItem = nameMatches && categoryMatches;

            item.style.display = showItem ? "" : "none";

            if (showItem) {
                visibleItems++;
            }
        });

        if (noCartSearchResult) {
            noCartSearchResult.style.display =
                cartItems.length > 0 && visibleItems === 0
                    ? "block"
                    : "none";
        }
    }


    /*
     * Stop the browser from submitting to a missing servlet.
     */
    if (cartSearchForm) {
        cartSearchForm.addEventListener("submit", function(event) {
            event.preventDefault();
            filterCartItems();
        });
    }


    /*
     * Live search, like the User Dashboard.
     */
    if (cartSearchInput) {
        cartSearchInput.addEventListener("input", filterCartItems);
    }

    if (cartCategorySelect) {
        cartCategorySelect.addEventListener("change", filterCartItems);
    }


    /*
     * Clear the search and show all cart items again.
     */
    if (clearCartSearch) {
        clearCartSearch.addEventListener("click", function() {
            cartSearchInput.value = "";
            cartCategorySelect.value = "all";
            filterCartItems();
        });
    }


    filterCartItems();
</script>

</body>
</html>
