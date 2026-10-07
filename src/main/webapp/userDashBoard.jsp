<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.entity.Product" %>

<%
String username = (String) session.getAttribute("username");

if (username == null || username.trim().isEmpty()) {
    username = "User";
}

List<Product> products =
        (List<Product>) request.getAttribute("product");
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Quick Shop - User Dashboard</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"
          rel="stylesheet">

    <style>

        /* =========================================================
           ROOT
        ========================================================= */

        :root {
            --qs-dark: #131921;
            --qs-sub: #232f3e;
            --qs-hover: #37475a;

            --qs-yellow: #ffd814;
            --qs-yellow-hover: #f7ca00;

            --qs-orange: #ffa41c;
            --qs-orange-hover: #fa8900;

            --qs-amber: #febd69;

            --qs-bg: #eaeded;
            --qs-border: #d5d9d9;

            --qs-text: #0f1111;
            --qs-muted: #565959;

            --qs-green: #007600;
            --qs-red: #b12704;
        }


        /* =========================================================
           GENERAL
        ========================================================= */

        * {
            box-sizing: border-box;
        }

        html {
            scroll-behavior: smooth;
        }

        body {
            margin: 0;
            background: var(--qs-bg);
            color: var(--qs-text);

            font-family:
                "Segoe UI",
                system-ui,
                -apple-system,
                sans-serif;

            overflow-x: hidden;
        }


        /* =========================================================
           HEADER
        ========================================================= */

        .qs-header {
            width: 100%;
            background: var(--qs-dark);
            color: white;
        }


        /* =========================================================
           TOP BAR
        ========================================================= */

        .qs-topbar {
            width: 100%;
            padding: 8px 12px;
            background: var(--qs-dark);
        }

        .qs-topbar-inner {
            width: 100%;

            display: grid;

            grid-template-columns:
                auto
                minmax(0, 1fr)
                auto;

            align-items: center;

            gap: 12px;
        }


        /* =========================================================
           LOGO
        ========================================================= */

        .qs-logo {
            color: white;

            text-decoration: none;

            font-size: 1.5rem;

            font-weight: 800;

            white-space: nowrap;

            display: flex;

            align-items: center;

            gap: 5px;

            padding: 6px 5px;
        }

        .qs-logo i {
            color: var(--qs-amber);
            font-size: 1.55rem;
        }

        .qs-logo span {
            color: var(--qs-amber);
        }


        /* =========================================================
           SEARCH AREA
        ========================================================= */

        .qs-search-wrapper {
            width: 100%;
            min-width: 0;
        }

        .qs-search {
            width: 100%;
            margin: 0;
            padding: 0;
        }

        .qs-search .input-group {
            width: 100%;

            height: 50px;

            display: flex;

            flex-wrap: nowrap;

            align-items: stretch;

            border-radius: 6px;

            overflow: visible;
        }


        /* =========================================================
           CATEGORY DROPDOWN
        ========================================================= */

        .qs-category-dropdown {
            position: relative;

            width: 135px;

            min-width: 135px;

            flex: 0 0 135px;
        }

        .qs-category-select {
            width: 100%;

            height: 50px;

            border: none;

            border-right: 1px solid #ccc;

            border-radius: 6px 0 0 6px;

            background: #f3f3f3;

            color: #222;

            padding: 0 12px;

            display: flex;

            align-items: center;

            gap: 7px;

            font-size: 0.82rem;

            cursor: pointer;

            white-space: nowrap;
        }

        .qs-category-select:hover {
            background: #e8e8e8;
        }

        .qs-category-select > i:first-child {
            color: #f39c12;
            font-size: 1rem;
        }

        .qs-category-select span {
            overflow: hidden;

            text-overflow: ellipsis;

            white-space: nowrap;
        }

        .qs-category-arrow {
            font-size: 0.58rem;

            margin-left: auto;

            flex-shrink: 0;
        }


        /* =========================================================
           CATEGORY MENU
        ========================================================= */

        .qs-category-menu {
            display: none;

            position: absolute;

            top: 52px;

            left: 0;

            width: 220px;

            background: white;

            border-radius: 0 0 7px 7px;

            border: 1px solid #ddd;

            box-shadow:
                0 5px 16px rgba(0, 0, 0, 0.25);

            z-index: 99999;

            overflow: hidden;
        }

        .qs-category-menu.show {
            display: block;
        }

        .qs-category-option {
            min-height: 45px;

            display: flex;

            align-items: center;

            gap: 13px;

            padding: 0 17px;

            color: #222;

            font-size: 0.91rem;

            cursor: pointer;

            white-space: nowrap;
        }

        .qs-category-option i {
            width: 20px;

            text-align: center;

            font-size: 1rem;

            flex-shrink: 0;
        }

        .qs-category-option:hover {
            background: #f1f1f1;
        }

        .qs-category-option.active {
            background: #146ff5;
            color: white;
        }

        .qs-category-option.active:hover {
            background: #146ff5;
        }


        /* =========================================================
           SEARCH INPUT
        ========================================================= */

        .qs-search input {
            flex: 1 1 auto;

            width: 1%;

            min-width: 0;

            height: 50px;

            border: none;

            border-radius: 0;

            background: white;

            color: #111;

            font-size: 0.95rem;

            padding: 8px 14px;

            outline: none;
        }

        .qs-search input:focus {
            box-shadow: none;
        }


        /* =========================================================
           SEARCH BUTTON
        ========================================================= */

        .qs-search button[type="submit"] {
            width: 52px;

            min-width: 52px;

            height: 50px;

            flex: 0 0 52px;

            border: none;

            border-radius: 0 6px 6px 0;

            background: var(--qs-amber);

            color: #111;

            display: flex;

            align-items: center;

            justify-content: center;

            cursor: pointer;
        }

        .qs-search button[type="submit"]:hover {
            background: #f3a847;
        }

        .qs-search button[type="submit"] i {
            font-size: 1.05rem;
        }


        /* =========================================================
           ACCOUNT / ORDERS / CART
        ========================================================= */

        .qs-user-actions {
            display: flex;

            align-items: center;

            justify-content: flex-end;

            gap: 3px;
        }

        .qs-nav-box {
            color: white;

            text-decoration: none;

            padding: 6px 8px;

            border: 1px solid transparent;

            border-radius: 3px;

            white-space: nowrap;
        }

        .qs-nav-box:hover {
            color: white;

            border-color: white;
        }

        .qs-small-text {
            display: block;

            font-size: 0.67rem;

            color: #ccc;
        }

        .qs-nav-title {
            font-size: 0.81rem;

            font-weight: 700;
        }


        /* =========================================================
           CART
        ========================================================= */

        .qs-cart-link {
            padding-left: 8px;
            padding-right: 5px;
        }

        .qs-cart-container {
            position: relative;

            display: flex;

            align-items: center;
        }

        .qs-cart-container > i {
            color: var(--qs-amber);

            font-size: 1.9rem;
        }

        .qs-cart-count {
            position: absolute;

            top: -5px;

            left: 13px;

            min-width: 18px;

            height: 18px;

            padding: 1px 5px;

            border-radius: 10px;

            background: var(--qs-yellow);

            color: #111;

            font-size: 0.68rem;

            font-weight: 700;

            display: flex;

            align-items: center;

            justify-content: center;
        }

        .qs-cart-text {
            font-weight: 700;

            font-size: 0.84rem;

            margin-left: 5px;
        }


        /* =========================================================
           CATEGORY NAVIGATION
        ========================================================= */

        .qs-category-bar {
            width: 100%;

            min-height: 42px;

            display: flex;

            align-items: center;

            gap: 0;

            background: var(--qs-sub);

            overflow-x: auto;

            overflow-y: hidden;

            white-space: nowrap;

            scrollbar-width: thin;
        }

        .qs-category-bar::-webkit-scrollbar {
            height: 3px;
        }

        .qs-category-bar::-webkit-scrollbar-thumb {
            background: #697586;

            border-radius: 5px;
        }

        .qs-category {
            color: white;

            text-decoration: none;

            padding: 8px 15px;

            min-height: 42px;

            display: inline-flex;

            align-items: center;

            gap: 5px;

            font-size: 0.84rem;

            white-space: nowrap;

            border: 1px solid transparent;

            flex-shrink: 0;
        }

        .qs-category:hover {
            color: white;

            border-color: white;
        }

        .qs-category.active {
            color: white;

            border-color: white;

            background: #2e3c4f;
        }


        /* =========================================================
           MAIN
        ========================================================= */

        .qs-main {
            padding: 14px;
        }


        /* =========================================================
           WELCOME
        ========================================================= */

        .qs-welcome {
            background:
                linear-gradient(
                    90deg,
                    #1f2937,
                    #374151
                );

            color: white;

            border-radius: 8px;

            padding: 16px;

            margin-bottom: 14px;
        }

        .qs-welcome h1 {
            font-size: 1.25rem;

            margin: 8px 0 4px;

            font-weight: 700;
        }

        .qs-welcome p {
            margin: 0;

            color: #ddd;

            font-size: 0.84rem;
        }


        /* =========================================================
           PRODUCT GRID
        ========================================================= */

        #productGrid {
            --bs-gutter-x: 12px;
            --bs-gutter-y: 12px;
        }


        /* =========================================================
           PRODUCT CARD
        ========================================================= */

        .qs-product-card {
            height: 100%;

            background: white;

            border: 1px solid var(--qs-border);

            border-radius: 8px;

            padding: 10px;

            display: flex;

            flex-direction: column;

            transition: 0.2s ease;

            min-width: 0;
        }

        .qs-product-card:hover {
            transform: translateY(-2px);

            box-shadow:
                0 5px 15px rgba(0, 0, 0, 0.08);
        }


        /* =========================================================
           IMAGE
        ========================================================= */

        .qs-image-box {
            height: 160px;

            background: #f7f7f7;

            border-radius: 6px;

            display: flex;

            align-items: center;

            justify-content: center;

            position: relative;

            overflow: hidden;

            margin-bottom: 8px;
        }

        .qs-image-box img {
            width: 100%;

            height: 100%;

            max-width: 100%;

            max-height: 100%;

            object-fit: contain;
        }


        /* =========================================================
           WISHLIST
        ========================================================= */

        .qs-wishlist {
            position: absolute;

            top: 7px;

            right: 7px;

            width: 30px;

            height: 30px;

            border-radius: 50%;

            border: 1px solid var(--qs-border);

            background: white;

            color: #666;

            display: flex;

            align-items: center;

            justify-content: center;

            z-index: 2;

            cursor: pointer;
        }

        .qs-wishlist:hover {
            color: var(--qs-red);
        }


        /* =========================================================
           PRODUCT CATEGORY
        ========================================================= */

        .qs-product-meta {
            display: flex;

            align-items: center;

            gap: 7px;

            min-width: 0;
        }

        .qs-category-badge {
            font-size: 0.65rem;

            background: #f1f5f9;

            color: #475569;

            border: 1px solid #d5d9d9;

            border-radius: 4px;

            padding: 3px 6px;

            white-space: nowrap;

            overflow: hidden;

            text-overflow: ellipsis;
        }

        .qs-prime {
            color: #00a8e1;

            font-size: 0.72rem;

            font-weight: 800;

            font-style: italic;
        }


        /* =========================================================
           PRODUCT NAME
        ========================================================= */

        .qs-product-name {
            color: var(--qs-text);

            text-decoration: none;

            font-size: 0.88rem;

            font-weight: 600;

            line-height: 1.3;

            margin: 6px 0;

            display: -webkit-box;

            -webkit-line-clamp: 2;

            -webkit-box-orient: vertical;

            overflow: hidden;
        }

        .qs-product-name:hover {
            color: #c7511f;
        }


        /* =========================================================
           RATING
        ========================================================= */

        .qs-stars {
            color: #de7921;

            font-size: 0.76rem;
        }


        /* =========================================================
           PRICE
        ========================================================= */

        .qs-price {
            font-size: 1.12rem;

            font-weight: 700;
        }


        /* =========================================================
           STOCK
        ========================================================= */

        .qs-stock {
            font-size: 0.75rem;

            font-weight: 600;

            margin: 5px 0 8px;
        }

        .qs-stock-in {
            color: var(--qs-green);
        }

        .qs-stock-low {
            color: var(--qs-red);
        }

        .qs-stock-out {
            color: #777;
        }


        /* =========================================================
           BUTTONS
        ========================================================= */

        .qs-buttons {
            margin-top: auto;

            display: grid;

            gap: 5px;
        }

        .qs-cart-btn {
            background: var(--qs-yellow);

            border: 1px solid #fcd200;

            border-radius: 20px;

            padding: 6px;

            font-size: 0.78rem;

            cursor: pointer;
        }

        .qs-cart-btn:hover {
            background: var(--qs-yellow-hover);
        }

        .qs-buy-btn {
            background: var(--qs-orange);

            border: 1px solid #ff8f00;

            border-radius: 20px;

            padding: 6px;

            font-size: 0.78rem;

            cursor: pointer;
        }

        .qs-buy-btn:hover {
            background: var(--qs-orange-hover);
        }


        /* =========================================================
           NO PRODUCTS
        ========================================================= */

        .qs-no-products {
            background: white;

            border: 1px solid var(--qs-border);

            border-radius: 8px;

            padding: 45px 20px;

            text-align: center;

            color: #666;
        }

        .qs-no-products i {
            font-size: 3rem;

            color: #aaa;
        }


        /* =========================================================
           FOOTER
        ========================================================= */

        .qs-back-top {
            display: block;

            background: var(--qs-hover);

            color: white;

            text-align: center;

            padding: 12px;

            text-decoration: none;

            font-size: 0.82rem;
        }

        .qs-back-top:hover {
            color: white;

            background: #485769;
        }

        .qs-footer {
            background: var(--qs-dark);

            color: #aaa;

            text-align: center;

            padding: 18px;

            font-size: 0.75rem;
        }


        /* =========================================================
           TABLET
        ========================================================= */

        @media (min-width: 768px)
        and (max-width: 1100px) {

            .qs-topbar-inner {
                grid-template-columns:
                    auto
                    minmax(0, 1fr)
                    auto;

                gap: 6px;
            }

            .qs-logo {
                font-size: 1.25rem;
            }

            .qs-account,
            .qs-orders {
                display: none;
            }

            .qs-category-dropdown {
                width: 125px;

                min-width: 125px;

                flex-basis: 125px;
            }

            .qs-image-box {
                height: 160px;
            }
        }


        /* =========================================================
           MOBILE
        ========================================================= */

        @media (max-width: 767.98px) {

            .qs-topbar {
                padding: 7px;
            }

            .qs-topbar-inner {
                grid-template-columns:
                    1fr
                    auto;

                grid-template-rows:
                    auto
                    auto;

                gap: 5px 8px;
            }

            .qs-logo {
                grid-column: 1;

                grid-row: 1;

                font-size: 1.15rem;

                padding: 4px;
            }

            .qs-logo i {
                font-size: 1.25rem;
            }

            .qs-user-actions {
                grid-column: 2;

                grid-row: 1;
            }

            .qs-account,
            .qs-orders {
                display: none;
            }

            .qs-cart-link {
                padding: 3px 5px;
            }

            .qs-cart-container > i {
                font-size: 1.7rem;
            }

            .qs-cart-text {
                display: none;
            }

            .qs-search-wrapper {
                grid-column: 1 / -1;

                grid-row: 2;

                width: 100%;
            }

            .qs-search {
                width: 100%;
            }

            .qs-search .input-group {
                height: 42px;
            }

            .qs-category-dropdown {
                width: 105px;

                min-width: 105px;

                flex-basis: 105px;
            }

            .qs-category-select {
                height: 42px;

                padding: 0 7px;

                gap: 4px;

                font-size: 0.70rem;
            }

            .qs-category-select > i:first-child {
                font-size: 0.85rem;
            }

            .qs-category-arrow {
                font-size: 0.5rem;
            }

            .qs-category-menu {
                top: 44px;

                width: 215px;
            }

            .qs-category-option {
                min-height: 44px;

                font-size: 0.86rem;
            }

            .qs-search input {
                height: 42px;

                font-size: 0.78rem;

                padding: 7px 9px;
            }

            .qs-search button[type="submit"] {
                width: 44px;

                min-width: 44px;

                height: 42px;

                flex-basis: 44px;
            }

            .qs-category-bar {
                min-height: 40px;
            }

            .qs-category {
                min-height: 40px;

                padding: 7px 10px;

                font-size: 0.73rem;
            }

            .qs-main {
                padding: 9px;
            }

            .qs-welcome {
                padding: 12px;

                margin-bottom: 10px;
            }

            .qs-welcome h1 {
                font-size: 1rem;
            }

            .qs-welcome p {
                font-size: 0.76rem;

                line-height: 1.4;
            }

            #productGrid {
                --bs-gutter-x: 8px;

                --bs-gutter-y: 8px;
            }

            .qs-product-card {
                padding: 8px;

                border-radius: 7px;
            }

            .qs-image-box {
                height: 135px;

                margin-bottom: 7px;
            }

            .qs-wishlist {
                width: 28px;

                height: 28px;

                top: 6px;

                right: 6px;
            }

            .qs-category-badge {
                font-size: 0.59rem;

                padding: 3px 5px;
            }

            .qs-prime {
                font-size: 0.68rem;
            }

            .qs-product-name {
                font-size: 0.80rem;

                margin: 5px 0;
            }

            .qs-stars {
                font-size: 0.68rem;
            }

            .qs-price {
                font-size: 1rem;
            }

            .qs-stock {
                font-size: 0.68rem;

                margin: 4px 0 7px;
            }

            .qs-cart-btn,
            .qs-buy-btn {
                padding: 5px;

                font-size: 0.68rem;
            }
        }


        /* =========================================================
           VERY SMALL MOBILE
        ========================================================= */

        @media (max-width: 400px) {

            .qs-logo {
                font-size: 1rem;
            }

            .qs-category-dropdown {
                width: 95px;

                min-width: 95px;

                flex-basis: 95px;
            }

            .qs-category-select {
                font-size: 0.65rem;

                padding: 0 5px;
            }

            .qs-image-box {
                height: 125px;
            }

            .qs-product-card {
                padding: 7px;
            }

            .qs-product-name {
                font-size: 0.76rem;
            }

            .qs-price {
                font-size: 0.95rem;
            }

            .qs-cart-btn,
            .qs-buy-btn {
                font-size: 0.64rem;

                padding: 5px;
            }
        }

    </style>

</head>


<body>


<!-- =========================================================
     HEADER
========================================================= -->

<header class="qs-header">


    <!-- TOP HEADER -->

    <div class="qs-topbar">

        <div class="qs-topbar-inner">


            <!-- LOGO -->

            <a href="#"
               class="qs-logo">

                <i class="bi bi-cart3"></i>

                Quick<span>Shop</span>

            </a>


            <!-- SEARCH -->

            <div class="qs-search-wrapper">

                <form class="qs-search"
                      id="searchForm">

                    <div class="input-group">


                        <!-- CATEGORY -->

                        <div class="qs-category-dropdown">

                            <button type="button"
                                    class="qs-category-select"
                                    id="categoryButton">

                                <i class="bi bi-funnel"></i>

                                <span id="selectedCategory">
                                    All Categories
                                </span>

                                <i class="bi bi-caret-down-fill qs-category-arrow"></i>

                            </button>


                            <!-- CATEGORY MENU -->

                            <div class="qs-category-menu"
                                 id="categoryMenu">


                                <!-- ALL -->

                                <div class="qs-category-option active"
                                     data-category="all">

                                    <i class="bi bi-list"></i>

                                    <span>All Categories</span>

                                </div>


                                <!-- ELECTRONICS -->

                                <div class="qs-category-option"
                                     data-category="electronics">

                                    <i class="bi bi-laptop"></i>

                                    <span>Electronics</span>

                                </div>


                                <!-- CLOTHES -->

                                <div class="qs-category-option"
                                     data-category="clothes">

                                    <i class="bi bi-handbag"></i>

                                    <span>Clothes</span>

                                </div>


                                <!-- HOME & KITCHEN -->

                                <div class="qs-category-option"
                                     data-category="home">

                                    <i class="bi bi-house"></i>

                                    <span>Home & Kitchen</span>

                                </div>


                                <!-- COMPUTERS -->

                                <div class="qs-category-option"
                                     data-category="computers">

                                    <i class="bi bi-cpu"></i>

                                    <span>Computers & Acc.</span>

                                </div>


                                <!-- BOOKS -->

                                <div class="qs-category-option"
                                     data-category="books">

                                    <i class="bi bi-book"></i>

                                    <span>Books</span>

                                </div>


                                <!-- SPORTS -->

                                <div class="qs-category-option"
                                     data-category="sports">

                                    <i class="bi bi-activity"></i>

                                    <span>Sports</span>

                                </div>

                            </div>

                        </div>


                        <!-- SEARCH INPUT -->

                        <input type="search"
                               class="form-control"
                               id="searchInput"
                               placeholder="Search products...">


                        <!-- SEARCH BUTTON -->

                        <button type="submit"
                                aria-label="Search">

                            <i class="bi bi-search"></i>

                        </button>

                    </div>

                </form>

            </div>


            <!-- ACCOUNT / CART -->

            <div class="qs-user-actions">


                <!-- ACCOUNT -->

                <a href="#"
                   class="qs-nav-box qs-account">

                    <span class="qs-small-text">
                        Hello, <%= username %>
                    </span>

                    <span class="qs-nav-title">

                        Account & Lists

                        <i class="bi bi-caret-down-fill"></i>

                    </span>

                </a>


                <!-- ORDERS -->

                <a href="#"
                   class="qs-nav-box qs-orders">

                    <span class="qs-small-text">
                        Returns
                    </span>

                    <span class="qs-nav-title">
                        & Orders
                    </span>

                </a>


                <!-- CART -->

                <a href="#"
                   class="qs-nav-box qs-cart-link">

                    <div class="qs-cart-container">

                        <i class="bi bi-cart2"></i>

                        <span class="qs-cart-count">
                            3
                        </span>

                        <span class="qs-cart-text">
                            Cart
                        </span>

                    </div>

                </a>

            </div>

        </div>

    </div>


    <!-- CATEGORY NAVIGATION -->

    <nav class="qs-category-bar">


        <!-- ALL -->

        <a href="#"
           class="qs-category active"
           data-category="all">

            <i class="bi bi-list"></i>

            All

        </a>


        <!-- ELECTRONICS -->

        <a href="#"
           class="qs-category"
           data-category="electronics">

            Electronics

        </a>


        <!-- CLOTHES -->

        <a href="#"
           class="qs-category"
           data-category="clothes">

            Clothes

        </a>


        <!-- HOME -->

        <a href="#"
           class="qs-category"
           data-category="home">

            Home & Kitchen

        </a>


        <!-- COMPUTERS -->

        <a href="#"
           class="qs-category"
           data-category="computers">

            Computers & Acc.

        </a>


        <!-- BOOKS -->

        <a href="#"
           class="qs-category"
           data-category="books">

            Books

        </a>


        <!-- SPORTS -->

        <a href="#"
           class="qs-category"
           data-category="sports">

            Sports

        </a>

    </nav>

</header>



<!-- =========================================================
     MAIN
========================================================= -->

<main class="qs-main">

    <div class="container-fluid">


        <!-- WELCOME -->

        <section class="qs-welcome">

            <span class="badge bg-warning text-dark">
                Fast Delivery
            </span>

            <h1>
                Welcome back, <%= username %>
            </h1>

            <p>
                Let's start the shopping.
                The best deals are waiting for you.
            </p>

        </section>


        <!-- PRODUCT GRID -->

        <section
            class="row row-cols-2 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 row-cols-xl-5 g-3"
            id="productGrid">


            <%
            if (products != null && !products.isEmpty()) {

                for (Product prod : products) {

                    String status;

                    String stockText;


                    if (prod.getProductQty() == 0) {

                        status = "out";

                        stockText = "Out of Stock";

                    }

                    else if (prod.getProductQty() <= 5) {

                        status = "low";

                        stockText =
                                "Only "
                                + prod.getProductQty()
                                + " left";

                    }

                    else {

                        status = "in";

                        stockText = "In Stock";

                    }


                    String productName =
                            prod.getProductName() == null
                            ? ""
                            : prod.getProductName()
                                    .trim()
                                    .toLowerCase();


                    String productCategory =
                            prod.getCategory() == null
                            ? ""
                            : prod.getCategory()
                                    .trim()
                                    .toLowerCase();

            %>


            <!-- PRODUCT -->

            <div class="col product-item"
                 data-name="<%= productName %>"
                 data-category="<%= productCategory %>">


                <article class="qs-product-card">


                    <!-- PRODUCT IMAGE -->

                    <div class="qs-image-box">


                        <!-- WISHLIST -->

                        <button
                            class="qs-wishlist"
                            type="button"
                            aria-label="Add to wishlist">

                            <i class="bi bi-heart"></i>

                        </button>


                        <%
                        if (prod.getImage() != null
                            && !prod.getImage().trim().isEmpty()) {
                        %>

                            <img
                                src="<%= prod.getImage() %>"
                                alt="<%= prod.getProductName() == null
                                      ? "Product"
                                      : prod.getProductName() %>"
                                loading="lazy"
                                onerror="this.style.display='none'; this.nextElementSibling.style.display='block';">


                            <i
                                class="bi bi-image"
                                style="font-size:3rem;color:#aaa;display:none;">
                            </i>


                        <%
                        } else {
                        %>

                            <i
                                class="bi bi-image"
                                style="font-size:3rem;color:#aaa;">
                            </i>

                        <%
                        }
                        %>

                    </div>


                    <!-- CATEGORY -->

                    <div class="qs-product-meta">

                        <span class="qs-prime">
                            prime
                        </span>

                        <span class="qs-category-badge">

                            <%= prod.getCategory() == null
                                ? ""
                                : prod.getCategory() %>

                        </span>

                    </div>


                    <!-- PRODUCT NAME -->

                    <a href="#"
                       class="qs-product-name">

                        <%= prod.getProductName() == null
                            ? "Product"
                            : prod.getProductName() %>

                    </a>


                    <!-- RATING -->

                    <div class="d-flex align-items-center mb-1">

                        <span class="qs-stars">

                            <i class="bi bi-star-fill"></i>
                            <i class="bi bi-star-fill"></i>
                            <i class="bi bi-star-fill"></i>
                            <i class="bi bi-star-fill"></i>
                            <i class="bi bi-star-half"></i>

                        </span>

                    </div>


                    <!-- PRICE -->

                    <div class="qs-price">

                        ₹ <%= String.format(
                                "%.2f",
                                prod.getProductPrice()
                            ) %>

                    </div>


                    <!-- STOCK -->

                    <div class="qs-stock
                        <% if ("in".equals(status)) { %>
                            qs-stock-in
                        <% }
                        else if ("low".equals(status)) { %>
                            qs-stock-low
                        <% }
                        else { %>
                            qs-stock-out
                        <% } %>
                    ">


                        <%
                        if ("in".equals(status)) {
                        %>

                            <i class="bi bi-check-circle-fill"></i>

                        <%
                        }
                        else if ("low".equals(status)) {
                        %>

                            <i class="bi bi-exclamation-triangle-fill"></i>

                        <%
                        }
                        else {
                        %>

                            <i class="bi bi-x-circle-fill"></i>

                        <%
                        }
                        %>


                        <%= stockText %>

                    </div>


                    <!-- BUTTONS -->

                    <div class="qs-buttons">


                        <!-- ADD TO CART -->

                        <button
                            type="button"
                            class="qs-cart-btn">

                            <i class="bi bi-cart-plus"></i>

                            Add to Cart

                        </button>


                        <!-- BUY NOW -->

                        <button
                            type="button"
                            class="qs-buy-btn">

                            <i class="bi bi-lightning-fill"></i>

                            Buy Now

                        </button>

                    </div>


                </article>

            </div>


            <%
                }
            }
            else {
            %>


            <!-- NO PRODUCTS -->

            <div class="col-12">

                <div class="qs-no-products">

                    <i class="bi bi-box-seam"></i>

                    <h5 class="mt-3">
                        No products found
                    </h5>

                    <p class="mb-0">
                        There is no product data available
                        in the database.
                    </p>

                </div>

            </div>


            <%
            }
            %>

        </section>


        <!-- SEARCH RESULT -->

        <div
            id="noSearchResult"
            class="qs-no-products mt-3 d-none">

            <i class="bi bi-search"></i>

            <h5 class="mt-3">
                No matching products
            </h5>

            <p class="mb-0">
                Try another product name or category.
            </p>

        </div>

    </div>

</main>



<!-- =========================================================
     FOOTER
========================================================= -->

<footer>


    <!-- BACK TO TOP -->

    <a href="#"
       class="qs-back-top"
       id="backToTop">

        Back to top

    </a>


    <!-- FOOTER -->

    <div class="qs-footer">

        © 2026 Quickshop.com dev - Mohan Patil.

    </div>

</footer>



<!-- =========================================================
     JAVASCRIPT
========================================================= -->

<script>


    /* =========================================================
       ELEMENTS
    ========================================================= */

    const searchInput =
        document.getElementById("searchInput");


    const searchForm =
        document.getElementById("searchForm");


    const products =
        document.querySelectorAll(".product-item");


    const noResult =
        document.getElementById("noSearchResult");


    const categoryLinks =
        document.querySelectorAll(".qs-category");


    const categoryButton =
        document.getElementById("categoryButton");


    const categoryMenu =
        document.getElementById("categoryMenu");


    const selectedCategoryText =
        document.getElementById("selectedCategory");


    const categoryOptions =
        document.querySelectorAll(".qs-category-option");


    /* =========================================================
       CURRENT CATEGORY
    ========================================================= */

    let selectedCategory = "all";


    /* =========================================================
       NORMALIZE CATEGORY
       SAME LOGIC AS ADMIN DASHBOARD
    ========================================================= */

    function normalizeCategory(category) {

        category =
            (category || "")
                .trim()
                .toLowerCase();


        /*
         * REMOVE EXTRA SPACES
         */

        category =
            category.replace(/\s+/g, " ");


        /*
         * ELECTRONICS
         */

        if (
            category === "electronic" ||
            category === "electronics"
        ) {

            return "electronics";
        }


        /*
         * CLOTHES / FASHION
         */

        if (
            category === "clothes" ||
            category === "cloth" ||
            category === "fashion"
        ) {

            return "clothes";
        }


        /*
         * HOME
         *
         * Database may contain:
         * home
         * home & kitchen
         * home and kitchen
         */

        if (
            category === "home" ||
            category === "home & kitchen" ||
            category === "home and kitchen"
        ) {

            return "home";
        }


        /*
         * COMPUTERS
         *
         * Database may contain:
         * computers
         * computer
         * computers & acc.
         * computers & accessories
         * computer & accessories
         * computer accessories
         */

        if (
            category === "computer" ||
            category === "computers" ||
            category === "computer & accessories" ||
            category === "computers & accessories" ||
            category === "computer accessories" ||
            category === "computers & acc." ||
            category === "computer & acc." ||
            category === "computers and accessories" ||
            category === "computer and accessories"
        ) {

            return "computers";
        }


        /*
         * BOOKS
         */

        if (
            category === "book" ||
            category === "books"
        ) {

            return "books";
        }


        /*
         * SPORTS
         *
         * Database may contain:
         * sport
         * sports
         */

        if (
            category === "sport" ||
            category === "sports"
        ) {

            return "sports";
        }


        /*
         * RETURN ORIGINAL CATEGORY
         * IF NO MAPPING FOUND
         */

        return category;
    }


    /* =========================================================
       CATEGORY MATCH
    ========================================================= */

    function categoryMatches(
        productCategory,
        selectedCategory
    ) {

        const normalizedProductCategory =
            normalizeCategory(productCategory);


        const normalizedSelectedCategory =
            normalizeCategory(selectedCategory);


        /*
         * ALL CATEGORIES
         */

        if (
            normalizedSelectedCategory === "all"
        ) {

            return true;
        }


        /*
         * NORMALIZED CATEGORY COMPARISON
         */

        return (
            normalizedProductCategory ===
            normalizedSelectedCategory
        );
    }


    /* =========================================================
       FILTER PRODUCTS
    ========================================================= */

    function filterProducts() {

        const searchText =
            searchInput.value
                .trim()
                .toLowerCase();


        let visibleProducts = 0;


        products.forEach(product => {


            const productName =
                (
                    product.dataset.name || ""
                )
                .trim()
                .toLowerCase();


            const productCategory =
                (
                    product.dataset.category || ""
                )
                .trim()
                .toLowerCase();


            /*
             * SEARCH MATCH
             */

            const nameMatch =
                productName.includes(searchText);


            /*
             * CATEGORY MATCH
             */

            const categoryMatch =
                categoryMatches(
                    productCategory,
                    selectedCategory
                );


            /*
             * SHOW PRODUCT
             */

            if (
                nameMatch &&
                categoryMatch
            ) {

                product.classList.remove("d-none");

                visibleProducts++;

            }

            /*
             * HIDE PRODUCT
             */

            else {

                product.classList.add("d-none");

            }

        });


        /*
         * SHOW NO RESULT ONLY WHEN
         * PRODUCTS EXIST BUT NONE MATCH
         */

        noResult.classList.toggle(
            "d-none",
            products.length === 0 ||
            visibleProducts !== 0
        );
    }


    /* =========================================================
       OPEN CATEGORY DROPDOWN
    ========================================================= */

    categoryButton.addEventListener(
        "click",
        function(event) {

            event.stopPropagation();

            categoryMenu.classList.toggle("show");

        }
    );


    /* =========================================================
       CATEGORY DROPDOWN OPTIONS
    ========================================================= */

    categoryOptions.forEach(option => {

        option.addEventListener(
            "click",
            function(event) {

                event.stopPropagation();


                /*
                 * GET CATEGORY
                 */

                selectedCategory =
                    normalizeCategory(
                        this.dataset.category
                    );


                /*
                 * UPDATE DROPDOWN TEXT
                 */

                selectedCategoryText.textContent =
                    this.querySelector("span")
                        .textContent
                        .trim();


                /*
                 * REMOVE ACTIVE
                 */

                categoryOptions.forEach(item => {

                    item.classList.remove("active");

                });


                /*
                 * ACTIVE SELECTED OPTION
                 */

                this.classList.add("active");


                /*
                 * CLOSE MENU
                 */

                categoryMenu.classList.remove("show");


                /*
                 * UPDATE NAVBAR
                 */

                updateNavbarActive();


                /*
                 * FILTER
                 */

                filterProducts();

            }
        );

    });


    /* =========================================================
       CLOSE DROPDOWN OUTSIDE
    ========================================================= */

    document.addEventListener(
        "click",
        function() {

            categoryMenu.classList.remove("show");

        }
    );


    /* =========================================================
       UPDATE NAVBAR ACTIVE
    ========================================================= */

    function updateNavbarActive() {

        categoryLinks.forEach(
            link => {

                link.classList.remove("active");


                const linkCategory =
                    normalizeCategory(
                        link.dataset.category || "all"
                    );


                if (
                    linkCategory ===
                    selectedCategory
                ) {

                    link.classList.add("active");

                }

            }
        );

    }


    /* =========================================================
       SEARCH FORM
    ========================================================= */

    searchForm.addEventListener(
        "submit",
        function(event) {

            event.preventDefault();

            filterProducts();

        }
    );


    /* =========================================================
       LIVE SEARCH
    ========================================================= */

    searchInput.addEventListener(
        "input",
        function() {

            filterProducts();

        }
    );


    /* =========================================================
       NAVBAR CATEGORY
    ========================================================= */

    categoryLinks.forEach(link => {

        link.addEventListener(
            "click",
            function(event) {

                event.preventDefault();


                /*
                 * GET AND NORMALIZE CATEGORY
                 */

                selectedCategory =
                    normalizeCategory(
                        this.dataset.category || "all"
                    );


                /*
                 * UPDATE NAVBAR ACTIVE
                 */

                categoryLinks.forEach(item => {

                    item.classList.remove("active");

                });


                this.classList.add("active");


                /*
                 * UPDATE DROPDOWN
                 */

                categoryOptions.forEach(option => {

                    option.classList.remove("active");


                    const optionCategory =
                        normalizeCategory(
                            option.dataset.category
                        );


                    if (
                        optionCategory ===
                        selectedCategory
                    ) {

                        option.classList.add("active");


                        selectedCategoryText.textContent =
                            option
                                .querySelector("span")
                                .textContent
                                .trim();

                    }

                });


                /*
                 * FILTER PRODUCTS
                 */

                filterProducts();

            }
        );

    });


    /* =========================================================
       WISHLIST
    ========================================================= */

    document
        .querySelectorAll(".qs-wishlist")
        .forEach(button => {

            button.addEventListener(
                "click",
                function() {

                    const icon =
                        this.querySelector("i");


                    /*
                     * CHANGE HEART ICON
                     */

                    if (
                        icon.classList.contains("bi-heart")
                    ) {

                        icon.classList.remove("bi-heart");

                        icon.classList.add("bi-heart-fill");

                        this.style.color = "#b12704";

                    }

                    else {

                        icon.classList.remove("bi-heart-fill");

                        icon.classList.add("bi-heart");

                        this.style.color = "";

                    }

                }
            );

        });


    /* =========================================================
       BACK TO TOP
    ========================================================= */

    document
        .getElementById("backToTop")
        .addEventListener(
            "click",
            function(event) {

                event.preventDefault();


                window.scrollTo({
                    top: 0,
                    behavior: "smooth"
                });

            }
        );


    /* =========================================================
       INITIAL FILTER
    ========================================================= */

    filterProducts();

</script>


</body>

</html>