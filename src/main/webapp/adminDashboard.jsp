<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.entity.Product" %>

<!DOCTYPE html>

<html lang="en">

<head>

<meta charset="utf-8"/>

<meta name="viewport"
      content="width=device-width, initial-scale=1.0"/>

<title>Quick Shop Admin Dashboard - Product Page</title>


<!-- =========================
     TAILWIND CSS
     ========================= -->

<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>


<!-- =========================
     BOOTSTRAP CSS
     ========================= -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
      rel="stylesheet"/>


<!-- =========================
     BOOTSTRAP ICONS
     ========================= -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"
      rel="stylesheet"/>


<!-- =========================
     TAILWIND CONFIG
     ========================= -->

<script>

tailwind.config = {

    theme: {

        extend: {

            colors: {

                amazonDark: '#131921',

                amazonNav: '#232F3E',

                amazonAccent: '#FF9900',

                amazonYellow: '#FEBD69',

                amazonYellowHover: '#F3A847',

                amazonBg: '#EAEDED'

            }

        }

    }

}

</script>


<!-- =========================
     CUSTOM CSS
     ========================= -->

<style>

* {
    box-sizing: border-box;
}


html,
body {

    margin: 0;

    padding: 0;

    width: 100%;

    min-height: 100%;

}


body {

    background-color: #EAEDED;

    font-family: "Segoe UI",
                 system-ui,
                 -apple-system,
                 sans-serif;

    color: #0F1111;

    overflow-x: hidden;

}


/* =========================
   AMAZON COLORS
   ========================= */

.bg-amazon-dark {

    background-color: #131921 !important;

}


.bg-amazon-nav {

    background-color: #232F3E !important;

}


.text-amazon-orange {

    color: #FF9900 !important;

}


/* =========================
   SIDEBAR
   ========================= */

.sidebar-link {

    color: #D5D9D9;

    text-decoration: none;

    padding: 11px 16px;

    display: flex;

    align-items: center;

    gap: 12px;

    border-radius: 8px;

    font-size: 0.95rem;

    font-weight: 500;

    transition: all 0.15s ease;

    border: 1px solid transparent;

}


.sidebar-link:hover {

    color: #FFFFFF;

    background-color: #37475A;

    border-color: #FF9900;

}


.sidebar-link.active {

    color: #111111;

    background-color: #febd69;

    font-weight: 700;

    border-color: #FF9900;

    box-shadow: 0 2px 5px rgba(0,0,0,0.15);

}


.sidebar-link.active i {

    color: #111111 !important;

}


/* =========================
   SEARCH BUTTON
   ========================= */

.amazon-search-addon {

    background-color: #febd69;

    border-color: #febd69;

    color: #0F1111;

    cursor: pointer;

    transition: background-color 0.2s;

}


.amazon-search-addon:hover {

    background-color: #f3a847;

}


/* =========================
   PRODUCT IMAGE
   ========================= */

.product-img-box {

    width: 52px;

    height: 52px;

    object-fit: cover;

    border-radius: 6px;

    border: 1px solid #E3E6E6;

    background-color: #FFFFFF;

    padding: 2px;

}


/* =========================
   TABLE
   ========================= */

.table-hover tbody tr:hover {

    background-color: #F7FAFA;

}


/* =========================
   STOCK BADGES
   ========================= */

.badge-in-stock {

    background-color: #E6F4EA;

    color: #137333;

    border: 1px solid #CEEAD6;

}


.badge-low-stock {

    background-color: #FEF7E0;

    color: #B06000;

    border: 1px solid #FEEFC3;

}


.badge-out-stock {

    background-color: #FCE8E6;

    color: #C5221F;

    border: 1px solid #FAD2CF;

}


/* =========================
   APP LAYOUT
   ========================= */

.app-layout {

    display: flex;

    width: 100%;

    min-height: 100vh;

}


/* =========================
   SIDEBAR
   ========================= */

.sidebar {

    width: 288px;

    min-width: 288px;

    min-height: 100vh;

    background-color: #131921;

    display: flex;

    flex-direction: column;

    justify-content: space-between;

    box-shadow: 2px 0 8px rgba(0,0,0,0.12);

    z-index: 50;

}


/* =========================
   CONTENT
   ========================= */

.content-area {

    min-width: 0;

    flex: 1;

    display: flex;

    flex-direction: column;

    min-height: 100vh;

}


.top-header {

    min-height: 64px;

}


.main-content {

    padding: 24px;

    width: 100%;

}


/* =========================
   PRODUCT CARD
   ========================= */

.product-card {

    width: 100%;

    overflow: hidden;

    border-radius: 12px;

    background: #ffffff;

    border: 1px solid #dee2e6;

    box-shadow: 0 2px 7px rgba(0,0,0,0.04);

}


/* =========================
   TABLE RESPONSIVE
   ========================= */

.table-responsive {

    width: 100%;

    overflow-x: auto;

    overflow-y: hidden;

    -webkit-overflow-scrolling: touch;

    scrollbar-width: thin;

}


#productsCatalogTable {

    min-width: 950px;

    margin-bottom: 0;

}


#productsCatalogTable th {

    white-space: nowrap;

    vertical-align: middle;

}


#productsCatalogTable td {

    white-space: nowrap;

}


/* =========================
   SEARCH
   ========================= */

.search-wrapper {

    min-width: 0;

}


.search-wrapper .input-group {

    width: 100%;

}


.admin-actions {

    flex-shrink: 0;

}


.sidebar-brand {

    min-height: 72px;

}


/* =========================
   CATEGORY DROPDOWN
   ========================= */

.category-dropdown-item {

    cursor: pointer;

}


.category-dropdown-item:hover {

    background-color: #f2f2f2;

}


.category-dropdown-item.active {

    background-color: #febd69;

    color: #111111;

    font-weight: 600;

}


/* =========================
   NO RESULT
   ========================= */

.no-filter-result {

    display: none;

}


/* =========================
   TABLET
   ========================= */

@media (max-width: 991.98px) {

    .sidebar {

        width: 220px;

        min-width: 220px;

    }


    .sidebar-link {

        padding: 10px 12px;

        font-size: 0.88rem;

        gap: 9px;

    }


    .sidebar-brand {

        padding-left: 14px !important;

        padding-right: 14px !important;

    }


    .main-content {

        padding: 18px;

    }


    .top-header {

        padding-left: 14px !important;

        padding-right: 14px !important;

    }


    .admin-user {

        display: none !important;

    }

}


/* =========================
   MOBILE
   ========================= */

@media (max-width: 767.98px) {

    .app-layout {

        display: block;

        min-height: 100vh;

    }


    .sidebar {

        width: 100%;

        min-width: 100%;

        min-height: auto;

        height: auto;

        display: block;

        position: relative;

    }


    .sidebar-brand {

        padding: 12px 15px !important;

        min-height: 62px;

    }


    .sidebar-brand .brand-arrow {

        display: none;

    }


    .sidebar-nav {

        display: grid;

        grid-template-columns: repeat(5, 1fr);

        gap: 5px;

        padding: 8px !important;

        margin-top: 0 !important;

    }


    .sidebar-link {

        min-width: 0;

        padding: 9px 4px;

        margin: 0;

        flex-direction: column;

        justify-content: center;

        align-items: center;

        gap: 4px;

        text-align: center;

        border-radius: 7px;

        font-size: 0.68rem;

        line-height: 1.1;

    }


    .sidebar-link i {

        font-size: 1.05rem !important;

    }


    .sidebar-footer {

        display: none;

    }


    .content-area {

        width: 100%;

        min-width: 0;

        display: block;

    }


    .top-header {

        position: relative !important;

        min-height: auto;

        padding: 10px !important;

        display: block !important;

    }


    .search-wrapper {

        width: 100%;

        max-width: none;

        margin-bottom: 9px;

    }


    .search-wrapper .input-group {

        width: 100%;

    }


    .search-wrapper .dropdown-toggle {

        padding-left: 8px !important;

        padding-right: 8px !important;

        font-size: 0.72rem !important;

    }


    .search-wrapper .form-control {

        min-width: 0;

        font-size: 0.78rem;

        padding: 9px 7px;

    }


    .search-wrapper .amazon-search-addon {

        padding-left: 12px !important;

        padding-right: 12px !important;

    }


    .admin-actions {

        width: 100%;

        display: flex;

        justify-content: space-between;

        align-items: center;

        gap: 8px;

    }


    .notification-btn {

        padding: 5px 8px !important;

    }


    #logOutBtn {

        flex: 1;

        max-width: 140px;

        justify-content: center;

    }


    .main-content {

        padding: 10px !important;

    }


    .product-card {

        border-radius: 9px;

    }


    .table-responsive {

        border-radius: 9px;

    }


    #productsCatalogTable {

        min-width: 900px;

        font-size: 0.82rem;

    }


    #productsCatalogTable th {

        padding: 11px 10px !important;

        font-size: 0.69rem;

    }


    #productsCatalogTable td {

        padding: 10px !important;

    }


    .product-img-box {

        width: 46px;

        height: 46px;

    }

}


/* =========================
   SMALL MOBILE
   ========================= */

@media (max-width: 575.98px) {

    .sidebar-brand {

        padding: 10px 12px !important;

    }


    .sidebar-brand .brand-text {

        font-size: 1.05rem !important;

    }


    .sidebar-brand .brand-icon {

        font-size: 1.35rem !important;

    }


    .sidebar-brand .admin-badge {

        font-size: 0.62rem;

        padding: 4px 6px !important;

    }


    .sidebar-nav {

        grid-template-columns: repeat(5, 1fr);

        gap: 3px;

        padding: 6px !important;

    }


    .sidebar-link {

        padding: 8px 2px;

        font-size: 0.61rem;

        gap: 3px;

    }


    .sidebar-link i {

        font-size: 0.95rem !important;

    }


    .top-header {

        padding: 8px !important;

    }


    .search-wrapper .dropdown-toggle {

        max-width: 105px;

        overflow: hidden;

        text-overflow: ellipsis;

        white-space: nowrap;

    }


    .search-wrapper .form-control {

        font-size: 0.74rem;

    }


    .search-wrapper .amazon-search-addon {

        padding-left: 10px !important;

        padding-right: 10px !important;

    }


    .main-content {

        padding: 8px !important;

    }


    .product-card-bottom {

        padding: 10px !important;

        text-align: center;

    }


    .product-card-bottom span {

        font-size: 0.72rem;

    }


    .inventory-text {

        display: none;

    }


    .dropdown-menu {

        max-width: 280px;

    }

}


/* =========================
   VERY SMALL PHONES
   ========================= */

@media (max-width: 380px) {

    .sidebar-link {

        font-size: 0.56rem;

    }


    .sidebar-link i {

        font-size: 0.88rem !important;

    }


    .search-wrapper .dropdown-toggle {

        max-width: 88px;

        padding-left: 6px !important;

        padding-right: 6px !important;

    }


    .search-wrapper .amazon-search-addon {

        padding-left: 8px !important;

        padding-right: 8px !important;

    }


    #productsCatalogTable {

        min-width: 880px;

    }

}


/* =========================
   TOUCH DEVICES
   ========================= */

@media (hover: none) {

    .sidebar-link:hover {

        background-color: transparent;

        border-color: transparent;

    }


    .sidebar-link.active:hover {

        background-color: #febd69;

        border-color: #FF9900;

    }

}


.sidebar,
.top-header {

    user-select: none;

}

</style>

</head>


<body class="min-h-screen antialiased">


<div class="app-layout">


<!-- =====================================================
     SIDEBAR
     ===================================================== -->

<aside class="sidebar">


    <div>


        <!-- BRAND -->

        <div class="sidebar-brand px-5 py-4 border-b border-gray-700/60 flex items-center justify-between">


            <div class="flex flex-col">


                <div class="flex items-center gap-2">

                    <i class="bi bi-cart3 text-amazon-orange text-2xl font-bold brand-icon"></i>

                    <span class="text-white font-extrabold tracking-tight text-xl brand-text">

                        Quick<span class="text-amazon-orange">Shop</span>

                    </span>

                </div>


                <svg class="w-24 h-3 ml-7 -mt-0.5 text-amazon-orange brand-arrow"
                     fill="none"
                     stroke="currentColor"
                     stroke-linecap="round"
                     stroke-width="2.6"
                     viewBox="0 0 100 15">

                    <path d="M 5 5 Q 50 16 95 4"></path>

                    <polygon fill="currentColor"
                             points="90,1 96,4 92,8"
                             stroke="none"></polygon>

                </svg>


            </div>


            <span class="badge bg-amazon-nav border border-gray-600 text-yellow-400 font-semibold px-2 py-1 rounded admin-badge">

                Admin

            </span>


        </div>


        <!-- SIDEBAR MENU -->

        <nav class="sidebar-nav p-3 space-y-1.5 mt-2">


            <a class="sidebar-link active"
               href="addProduct.html">

                <i class="bi bi-plus-circle-fill text-lg"></i>

                <span>Add Product</span>

            </a>


            <a class="sidebar-link"
               href="#">

                <i class="bi bi-pencil-square text-amazon-orange text-lg"></i>

                <span>Update Product</span>

            </a>


            <a class="sidebar-link"
               href="#">

                <i class="bi bi-trash3 text-red-400 text-lg"></i>

                <span>Delete Product</span>

            </a>


            <a class="sidebar-link"
               href="#">

                <i class="bi bi-people-fill text-amazon-orange text-lg"></i>

                <span>User Details</span>

            </a>


            <a class="sidebar-link"
               href="#">

                <i class="bi bi-box-seam-fill text-amazon-orange text-lg"></i>

                <span>Order Details</span>

            </a>


        </nav>


    </div>


    <!-- SIDEBAR FOOTER -->

    <footer class="sidebar-footer p-3 bg-amazon-nav border-t border-gray-700 text-gray-300">


        <div class="flex items-center justify-between pt-1 px-1">


            <div class="flex items-center gap-2">


                <div class="w-8 h-8 rounded-full bg-amazon-orange text-amazon-dark flex items-center justify-center font-bold text-xs">

                    AD

                </div>


                <div class="text-xs leading-tight">

                    <p class="font-bold text-white mb-0">

                        © 2026 Quickshop.com dev - Mohan Patil.

                    </p>


                    <p class="text-gray-400 text-[11px] mb-0">

                        Admin Workspace

                    </p>

                </div>


            </div>


            <i class="bi bi-shield-lock text-amazon-orange text-sm"></i>


        </div>


    </footer>


</aside>


<!-- =====================================================
     MAIN CONTENT
     ===================================================== -->

<div class="content-area">


<!-- =====================================================
     HEADER
     ===================================================== -->

<header class="top-header bg-amazon-dark px-4 py-2.5 flex flex-wrap items-center justify-between gap-3 shadow-md sticky top-0 z-40 border-b border-gray-800">


    <!-- SEARCH AREA -->

    <div class="search-wrapper flex-grow flex items-center max-w-4xl w-full md:w-auto">


        <div class="input-group">


            <!-- CATEGORY BUTTON -->

            <button aria-expanded="false"
                    class="btn btn-light bg-gray-100 dropdown-toggle text-xs md:text-sm font-semibold border-gray-300 px-3 text-gray-800 flex items-center gap-1"
                    data-bs-toggle="dropdown"
                    type="button">

                <i class="bi bi-funnel text-amazon-orange me-1"></i>

                <span id="selectedCategoryLabel">

                    All Categories

                </span>

            </button>


            <!-- =================================================
                 CATEGORY DROPDOWN
                 ================================================= -->

            <ul class="dropdown-menu shadow-lg border-0 text-sm">


                <!-- ALL -->

                <li>

                    <a class="dropdown-item category-dropdown-item active"
                       href="#"
                       data-category="All Categories">

                        <i class="bi bi-grid me-2"></i>

                        All Categories

                    </a>

                </li>


                <li>

                    <hr class="dropdown-divider">

                </li>


                <!-- ELECTRONICS -->

                <li>

                    <a class="dropdown-item category-dropdown-item"
                       href="#"
                       data-category="Electronics">

                        <i class="bi bi-laptop me-2"></i>

                        Electronics

                    </a>

                </li>


                <!-- FASHION -->

                <li>

                    <a class="dropdown-item category-dropdown-item"
                       href="#"
                       data-category="Fashion">

                        <i class="bi bi-bag me-2"></i>

                        Fashion

                    </a>

                </li>


                <!-- HOME -->

                <li>

                    <a class="dropdown-item category-dropdown-item"
                       href="#"
                       data-category="Home & Kitchen">

                        <i class="bi bi-house me-2"></i>

                        Home & Kitchen

                    </a>

                </li>


                <!-- COMPUTER -->

                <li>

                    <a class="dropdown-item category-dropdown-item"
                       href="#"
                       data-category="Computer & Accessories">

                        <i class="bi bi-cpu me-2"></i>

                        Computer & Accessories

                    </a>

                </li>


                <!-- BOOK -->

                <li>

                    <a class="dropdown-item category-dropdown-item"
                       href="#"
                       data-category="Book">

                        <i class="bi bi-book me-2"></i>

                        Book

                    </a>

                </li>


                <!-- SPORTS -->

                <li>

                    <a class="dropdown-item category-dropdown-item"
                       href="#"
                       data-category="Sports & Outdoor Gear">

                        <i class="bi bi-activity me-2"></i>

                        Sports & Outdoor Gear

                    </a>

                </li>


            </ul>


            <!-- SEARCH INPUT -->

            <input aria-label="product Search bar"
                   class="form-control text-sm border-0 py-2"
                   id="productSearchInput"
                   placeholder="Search product name, category, or ID..."
                   type="text">


            <!-- SEARCH BUTTON -->

            <button class="btn amazon-search-addon px-4 text-base font-bold flex items-center justify-center"
                    type="button">

                <i class="bi bi-search text-gray-900"></i>

            </button>


        </div>


    </div>


    <!-- ADMIN ACTIONS -->

    <div class="admin-actions flex items-center gap-3 ms-auto">


        <!-- NOTIFICATION -->

        <button class="notification-btn relative text-gray-300 hover:text-white p-2 text-lg"
                title="Notifications"
                type="button">

            <i class="bi bi-bell"></i>

            <span class="absolute top-1 right-1 w-2.5 h-2.5 bg-amazon-orange rounded-full"></span>

        </button>


        <!-- ADMIN NAME -->

        <div class="admin-user hidden lg:flex flex-col text-right text-xs leading-none text-gray-300 border-l border-gray-700 pl-3">

            <span class="text-gray-400 text-[10px]">

                Signed in as

            </span>


            <span class="font-bold text-white mt-1">

                <%= session.getAttribute("fName") %>

            </span>

        </div>


        <!-- LOGOUT -->

        <button class="btn btn-outline-warning text-amazon-yellow border-amazon-yellow font-semibold text-xs md:text-sm px-3.5 py-1.5 flex items-center gap-1.5 rounded"
                id="logOutBtn"
                type="button">

            <i class="bi bi-box-arrow-right"></i>

            <span>LogOut</span>

        </button>


    </div>


</header>


<!-- =====================================================
     MAIN PRODUCT TABLE
     ===================================================== -->

<main class="main-content">


<div class="product-card">


<div class="table-responsive">


<table class="table table-hover align-middle mb-0"
       id="productsCatalogTable">


<!-- TABLE HEADER -->

<thead class="bg-gray-100/80 border-b border-gray-200 text-gray-700 text-xs uppercase font-bold tracking-wider">


<tr>


<th class="py-3.5 px-4 w-12 text-center">

#

</th>


<th class="py-3.5 px-3 w-20">

productImage

</th>


<th class="py-3.5 px-4">

productName

</th>


<th class="py-3.5 px-4">

category

</th>


<th class="py-3.5 px-4">

productPrice

</th>


<th class="py-3.5 px-4">

productQty

</th>


<th class="py-3.5 px-4 text-center w-36">

Actions

</th>


</tr>


</thead>


<!-- TABLE BODY -->

<tbody class="divide-y divide-gray-200 text-sm"
       id="productTableBody">


<%

List<Product> products =
        (List<Product>) request.getAttribute("product");


if (products != null && !products.isEmpty())
{

    int count = 1;


    for (Product prod : products)
    {


        /* =========================
           STOCK STATUS
           ========================= */

        String status;

        String badgeClass;

        String badgeLabel;


        if (prod.getProductQty() == 0)
        {

            status = "out-of-stock";

            badgeClass = "badge-out-stock";

            badgeLabel = "0 (Out of stock)";

        }

        else if (prod.getProductQty() <= 5)
        {

            status = "low-stock";

            badgeClass = "badge-low-stock";

            badgeLabel =
                    prod.getProductQty()
                    + " left (Low Stock)";

        }

        else
        {

            status = "in-stock";

            badgeClass = "badge-in-stock";

            badgeLabel =
                    prod.getProductQty()
                    + " in stock";

        }


        /* =========================
           IMAGE HANDLING
           ========================= */

        String imageUrl =
                prod.getImage();


        if (imageUrl != null
                && !imageUrl.trim().isEmpty())
        {

            imageUrl =
                    imageUrl.trim();


            if (!imageUrl.startsWith("http://")
                    && !imageUrl.startsWith("https://"))
            {

                imageUrl =
                        request.getContextPath()
                        + "/images/"
                        + imageUrl;

            }

        }

        else
        {

            imageUrl =
                    "https://placehold.co/100x100?text=No+Image";

        }


        /* =========================
           CATEGORY VALUE
           ========================= */

        String productCategory =
                prod.getCategory();


        if (productCategory == null)
        {

            productCategory = "";

        }


        productCategory =
                productCategory.trim();

%>


<!-- PRODUCT ROW -->

<tr class="product-row"
    data-category="<%= productCategory %>"
    data-status="<%= status %>">


<!-- NUMBER -->

<td class="text-center font-mono text-xs text-gray-500">

<%= String.format("%02d", count) %>

</td>


<!-- IMAGE -->

<td>

<img src="<%= imageUrl %>"
     alt="<%= prod.getProductName() %>"
     class="product-img-box"
     loading="lazy"
     onerror="this.onerror=null; this.src='https://placehold.co/100x100?text=No+Image';">

</td>


<!-- PRODUCT NAME -->

<td>

<div class="font-bold text-gray-900">

<%= prod.getProductName() %>

</div>


<span class="text-xs text-gray-400 font-mono">

Product ID:
<%= prod.getProductId() %>

</span>

</td>


<!-- CATEGORY -->

<td>

<span class="badge bg-blue-50 text-blue-700 border border-blue-200 font-medium px-2 py-1">

<%= productCategory %>

</span>

</td>


<!-- PRICE -->

<td>

<div class="text-base font-bold text-gray-900">

₹ <%= prod.getProductPrice() %>

</div>


<span class="text-[11px] text-emerald-600">

Available

</span>

</td>


<!-- QUANTITY -->

<td>

<span class="badge <%= badgeClass %> rounded-pill px-3 py-1 font-semibold text-xs inline-flex items-center gap-1">


<%

if (prod.getProductQty() == 0)
{

%>

<i class="bi bi-x-circle"></i>

<%

}

else if (prod.getProductQty() <= 5)
{

%>

<i class="bi bi-exclamation-triangle"></i>

<%

}

else
{

%>

<i class="bi bi-check2-circle"></i>

<%

}

%>


<%= badgeLabel %>


</span>

</td>


<!-- ACTIONS -->

<td class="text-center">

<div class="btn-group btn-group-sm"
     role="group">


<!-- UPDATE -->

<a class="btn btn-outline-secondary"
   title="Update Product"
   href="updateProduct?productId=<%= prod.getProductId() %>">

    <i class="bi bi-pencil-square text-primary"></i>

</a>


<!-- DELETE -->

<a class="btn btn-outline-secondary"
   title="Delete Product"
   href="deleteProduct?productId=<%= prod.getProductId() %>"
   onclick="return confirm('Are you sure you want to delete this product?');">

    <i class="bi bi-trash3 text-danger"></i>

</a>


</div>

</td>


</tr>


<%

        count++;

    }

}

else

{

%>


<!-- NO PRODUCTS FROM DATABASE -->

<tr id="databaseNoProductsRow">

<td colspan="7"
    class="text-center py-5 text-gray-500">


<i class="bi bi-box-seam text-4xl text-gray-400"></i>


<div class="mt-2 font-semibold">

No products found

</div>


<div class="text-sm">

There is no product data available in the database.

</div>


</td>

</tr>


<%

}

%>


<!-- NO FILTER RESULT -->

<tr id="noFilterResultRow"
    class="no-filter-result">

<td colspan="7"
    class="text-center py-5 text-gray-500">


<i class="bi bi-search text-4xl text-gray-400"></i>


<div class="mt-2 font-semibold">

No matching products

</div>


<div class="text-sm">

No product matches the selected category or search.

</div>


</td>

</tr>


</tbody>


</table>


</div>


<!-- FOOTER -->

<div class="product-card-bottom px-4 py-3 bg-gray-50 border-t border-gray-200 flex flex-col sm:flex-row items-center justify-between gap-3 text-xs text-gray-600">


<span>

Showing

<span class="font-bold text-gray-900"
      id="visibleProductCount">

<%= products != null ? products.size() : 0 %>

</span>

products

</span>


<span class="text-gray-500 inventory-text">

Quick Shop Product Inventory

</span>


</div>


</div>


</main>


</div>


</div>


<!-- =====================================================
     BOOTSTRAP JAVASCRIPT
     ===================================================== -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>


<!-- =====================================================
     CUSTOM JAVASCRIPT
     ===================================================== -->

<script>


/* =====================================================
   SELECTED CATEGORY
   ===================================================== */

let selectedCategory = 'All Categories';



/* =====================================================
   SEARCH INPUT
   ===================================================== */

const searchInput =
        document.getElementById(
            'productSearchInput'
        );



/* =====================================================
   CATEGORY NORMALIZATION
   =====================================================

   This is the important fix.

   Database can contain:

   home
   Home
   Home & Kitchen

   computers
   computer
   Computer & Accessories

   sport
   sports
   Sports & Outdoor Gear

   All of these are converted to
   one common category name.
   ===================================================== */

function normalizeCategory(category)
{

    if (!category)
    {

        return '';

    }


    let value =
        category
            .toString()
            .trim()
            .replace(/\s+/g, ' ')
            .toLowerCase();


    /*
     * Remove unnecessary spaces around &
     */

    value =
        value.replace(
            /\s*&\s*/g,
            ' & '
        );


    /* =========================
       ELECTRONICS
       ========================= */

    if (
        value === 'electronics'
        ||
        value === 'electronic'
    )
    {

        return 'electronics';

    }


    /* =========================
       FASHION
       ========================= */

    if (
        value === 'fashion'
        ||
        value === 'clothes'
        ||
        value === 'clothing'
    )
    {

        return 'fashion';

    }


    /* =========================
       HOME
       ========================= */

    if (
        value === 'home'
        ||
        value === 'home & kitchen'
        ||
        value === 'home and kitchen'
        ||
        value === 'home kitchen'
    )
    {

        return 'home';

    }


    /* =========================
       COMPUTER
       ========================= */

    if (
        value === 'computer'
        ||
        value === 'computers'
        ||
        value === 'computer & accessories'
        ||
        value === 'computer and accessories'
        ||
        value === 'computers & accessories'
        ||
        value === 'computers and accessories'
        ||
        value === 'computer accessories'
    )
    {

        return 'computers';

    }


    /* =========================
       BOOK
       ========================= */

    if (
        value === 'book'
        ||
        value === 'books'
    )
    {

        return 'book';

    }


    /* =========================
       SPORTS
       ========================= */

    if (
        value === 'sport'
        ||
        value === 'sports'
        ||
        value === 'sports & outdoor gear'
        ||
        value === 'sports and outdoor gear'
        ||
        value === 'sport & outdoor gear'
        ||
        value === 'sport and outdoor gear'
    )
    {

        return 'sports';

    }


    /*
     * If category is something else,
     * return normalized original value.
     */

    return value;

}



/* =====================================================
   FILTER PRODUCTS
   ===================================================== */

function filterProducts()
{

    /*
     * Get search text
     */

    const term =
        searchInput
            ? searchInput.value
                .toLowerCase()
                .trim()
            : '';


    /*
     * Normalize selected category
     */

    const selected =
        normalizeCategory(
            selectedCategory
        );


    /*
     * Get all product rows
     */

    const rows =
        document.querySelectorAll(
            '#productTableBody .product-row'
        );


    /*
     * Visible product counter
     */

    let visibleCount = 0;


    /*
     * Check every product
     */

    rows.forEach(function(row)
    {

        /*
         * Get database category
         */

        const rowCategory =
            normalizeCategory(
                row.getAttribute(
                    'data-category'
                )
            );


        /*
         * Get complete product text
         */

        const rowText =
            (
                row.innerText || ''
            )
            .toLowerCase();


        /*
         * CATEGORY MATCH
         */

        const categoryMatch =
            selected === ''
            ||
            selected === 'all categories'
            ||
            rowCategory === selected;


        /*
         * SEARCH MATCH
         */

        const searchMatch =
            term === ''
            ||
            rowText.includes(term);


        /*
         * FINAL MATCH
         */

        const shouldShow =
            categoryMatch
            &&
            searchMatch;


        /*
         * SHOW / HIDE ROW
         */

        if (shouldShow)
        {

            row.style.display = '';

            visibleCount++;

        }

        else
        {

            row.style.display = 'none';

        }

    });


    /*
     * Update product count
     */

    const countElement =
        document.getElementById(
            'visibleProductCount'
        );


    if (countElement)
    {

        countElement.innerText =
                visibleCount;

    }


    /*
     * Show "No matching products"
     */

    const noFilterResult =
        document.getElementById(
            'noFilterResultRow'
        );


    if (noFilterResult)
    {

        if (
            rows.length > 0
            &&
            visibleCount === 0
        )
        {

            noFilterResult.style.display =
                    'table-row';

        }

        else
        {

            noFilterResult.style.display =
                    'none';

        }

    }

}



/* =====================================================
   CATEGORY DROPDOWN CLICK
   ===================================================== */

const categoryItems =
        document.querySelectorAll(
            '.category-dropdown-item'
        );


categoryItems.forEach(function(item)
{

    item.addEventListener(
        'click',
        function(event)
        {

            /*
             * Prevent page navigation
             */

            event.preventDefault();


            /*
             * Get selected category
             */

            const category =
                    item.getAttribute(
                        'data-category'
                    );


            /*
             * Set selected category
             */

            selectCategory(category);


            /*
             * Remove active class
             * from every category
             */

            categoryItems.forEach(
                function(otherItem)
                {

                    otherItem.classList.remove(
                        'active'
                    );

                }
            );


            /*
             * Add active class
             * to selected category
             */

            item.classList.add(
                'active'
            );

        }
    );

});



/* =====================================================
   SELECT CATEGORY
   ===================================================== */

function selectCategory(categoryName)
{

    /*
     * Save selected category
     */

    selectedCategory =
            categoryName;


    /*
     * Change dropdown button text
     */

    const label =
            document.getElementById(
                'selectedCategoryLabel'
            );


    if (label)
    {

        label.innerText =
                categoryName;

    }


    /*
     * Apply filter
     */

    filterProducts();

}



/* =====================================================
   SEARCH EVENT
   ===================================================== */

if (searchInput)
{

    searchInput.addEventListener(
        'input',
        function()
        {

            filterProducts();

        }
    );

}



/* =====================================================
   SEARCH BUTTON
   ===================================================== */

const searchButton =
        document.querySelector(
            '.amazon-search-addon'
        );


if (searchButton)
{

    searchButton.addEventListener(
        'click',
        function()
        {

            filterProducts();

        }
    );

}



/* =====================================================
   LOGOUT
   ===================================================== */

const logOutBtn =
        document.getElementById(
            'logOutBtn'
        );


if (logOutBtn)
{

    logOutBtn.addEventListener(
        'click',
        function()
        {

            if (
                confirm(
                    'Are you sure you want to log out?'
                )
            )
            {

                window.location.href =
                        'index.html';

            }

        }
    );

}



/* =====================================================
   INITIAL FILTER
   ===================================================== */

document.addEventListener(
    'DOMContentLoaded',
    function()
    {

        filterProducts();

    }
);

</script>


</body>

</html>