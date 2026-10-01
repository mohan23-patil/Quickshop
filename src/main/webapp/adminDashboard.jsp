<%@ page language="java"
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.entity.Product" %>

<!DOCTYPE html>

<html lang="en">

<head>

<meta charset="utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>

<title>Quick Shop Admin Dashboard - Product Page</title>

<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
      rel="stylesheet"/>

<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"
      rel="stylesheet"/>

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

    font-family: "Segoe UI", system-ui, -apple-system, sans-serif;

    color: #0F1111;

    overflow-x: hidden;

}

.bg-amazon-dark {
    background-color: #131921 !important;
}

.bg-amazon-nav {
    background-color: #232F3E !important;
}

.text-amazon-orange {
    color: #FF9900 !important;
}

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

.product-img-box {

    width: 52px;

    height: 52px;

    object-fit: cover;

    border-radius: 6px;

    border: 1px solid #E3E6E6;

    background-color: #FFFFFF;

    padding: 2px;

}

.table-hover tbody tr:hover {
    background-color: #F7FAFA;
}

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

.app-layout {

    display: flex;

    width: 100%;

    min-height: 100vh;

}

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

.product-card {

    width: 100%;

    overflow: hidden;

    border-radius: 12px;

    background: #ffffff;

    border: 1px solid #dee2e6;

    box-shadow: 0 2px 7px rgba(0,0,0,0.04);

}

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

/* Tablet */

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

/* Mobile */

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

/* Small mobile */

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

        max-width: 250px;

    }

}

/* Very small phones */

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

/* Touch devices */

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

<aside class="sidebar">

<div>

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

<footer class="sidebar-footer p-3 bg-amazon-nav border-t border-gray-700 text-gray-300">

<div class="flex items-center justify-between pt-1 px-1">

<div class="flex items-center gap-2">

<div class="w-8 h-8 rounded-full bg-amazon-orange text-amazon-dark flex items-center justify-center font-bold text-xs">
AD
</div>

<div class="text-xs leading-tight">

<p class="font-bold text-white mb-0">
@2026 quickshop.com
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

<div class="content-area">

<header class="top-header bg-amazon-dark px-4 py-2.5 flex flex-wrap items-center justify-between gap-3 shadow-md sticky top-0 z-40 border-b border-gray-800">

<div class="search-wrapper flex-grow flex items-center max-w-4xl w-full md:w-auto">

<div class="input-group">

<button aria-expanded="false"
     class="btn btn-light bg-gray-100 dropdown-toggle text-xs md:text-sm font-semibold border-gray-300 px-3 text-gray-800 flex items-center gap-1"
     data-bs-toggle="dropdown"
     type="button">

<i class="bi bi-funnel text-amazon-orange me-1"></i>

<span id="selectedCategoryLabel">
All Categories
</span>

</button>

<ul class="dropdown-menu shadow-lg border-0 text-sm">

<li>

<a class="dropdown-item active"
href="#"
onclick="selectCategory('All Categories'); return false;">

All Categories

</a>

</li>

<li>
<hr class="dropdown-divider">
</li>

<li>

<a class="dropdown-item"
href="#"
onclick="selectCategory('Electronics'); return false;">

<i class="bi bi-laptop me-2"></i>
Electronics

</a>

</li>

<li>

<a class="dropdown-item"
href="#"
onclick="selectCategory('Clothes'); return false;">

<i class="bi bi-bag me-2"></i>
Clothes

</a>

</li>

<li>

<a class="dropdown-item"
href="#"
onclick="selectCategory('Home & Kitchen'); return false;">

<i class="bi bi-house me-2"></i>
Home & Kitchen

</a>

</li>

<li>

<a class="dropdown-item"
href="#"
onclick="selectCategory('Computers & Accessories'); return false;">

<i class="bi bi-cpu me-2"></i>
Computers & Acc.

</a>

</li>

<li>

<a class="dropdown-item"
href="#"
onclick="selectCategory('Books & Media'); return false;">

<i class="bi bi-book me-2"></i>
Books

</a>

</li>

<li>

<a class="dropdown-item"
href="#"
onclick="selectCategory('Fitness & Sports'); return false;">

<i class="bi bi-activity me-2"></i>
Sports

</a>

</li>

</ul>

<input aria-label="product Search bar"
    class="form-control text-sm border-0 py-2"
    id="productSearchInput"
    placeholder="Search product name, category, or ID..."
    type="text">

<button class="btn amazon-search-addon px-4 text-base font-bold flex items-center justify-center"
     type="button">

<i class="bi bi-search text-gray-900"></i>

</button>

</div>

</div>

<div class="admin-actions flex items-center gap-3 ms-auto">

<button class="notification-btn relative text-gray-300 hover:text-white p-2 text-lg"
     title="Notifications"
     type="button">

<i class="bi bi-bell"></i>

<span class="absolute top-1 right-1 w-2.5 h-2.5 bg-amazon-orange rounded-full"></span>

</button>

<div class="admin-user hidden lg:flex flex-col text-right text-xs leading-none text-gray-300 border-l border-gray-700 pl-3">

<span class="text-gray-400 text-[10px]">
Signed in as
</span>

<span class="font-bold text-white mt-1">
<%= session.getAttribute("fName") %>
</span>

</div>

<button class="btn btn-outline-warning text-amazon-yellow border-amazon-yellow font-semibold text-xs md:text-sm px-3.5 py-1.5 flex items-center gap-1.5 rounded"
     id="logOutBtn"
     type="button">

<i class="bi bi-box-arrow-right"></i>

<span>LogOut</span>

</button>

</div>

</header>

<main class="main-content">

<div class="product-card">

<div class="table-responsive">

<table class="table table-hover align-middle mb-0"
       id="productsCatalogTable">

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

        badgeLabel = prod.getProductQty() + " left (Low Stock)";

    }
    else
    {

        status = "in-stock";

        badgeClass = "badge-in-stock";

        badgeLabel = prod.getProductQty() + " in stock";

    }


%>

<tr class="product-row"
    data-category="<%= prod.getCategory() %>"
    data-status="<%= status %>">

<td class="text-center font-mono text-xs text-gray-500">

<%= String.format("%02d", count) %>

</td>

<td>

<img src="<%= request.getContextPath() %>/images/<%= prod.getImage() %>"
  alt="<%= prod.getProductName() %>"
  class="product-img-box"
  onerror="this.onerror=null; this.src='https://placehold.co/100x100?text=No+Image';">

</td>

<td>

<div class="font-bold text-gray-900">

<%= prod.getProductName() %>

</div>

<span class="text-xs text-gray-400 font-mono">

Product ID: <%= prod.getProductId() %>

</span>

</td>

<td>

<span class="badge bg-blue-50 text-blue-700 border border-blue-200 font-medium px-2 py-1">

<%= prod.getCategory() %>

</span>

</td>

<td>

<div class="text-base font-bold text-gray-900">

₹ <%= prod.getProductPrice() %>

</div>

<span class="text-[11px] text-emerald-600">

Available

</span>

</td>

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

<td class="text-center">

<div class="btn-group btn-group-sm"
     role="group">

<a class="btn btn-outline-secondary"
title="Update Product"
href="updateProduct?productId=<%= prod.getProductId() %>">

<i class="bi bi-pencil-square text-primary"></i>

</a>

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

<tr>

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

</tbody>

</table>

</div>

<div class="product-card-bottom px-4 py-3 bg-gray-50 border-t border-gray-200 flex flex-col sm:flex-row items-center justify-between gap-3 text-xs text-gray-600">

<span>

Showing

<span class="font-bold text-gray-900">

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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>

const searchInput =
    document.getElementById('productSearchInput');

if (searchInput) {

    searchInput.addEventListener('input', function(e) {

        const term =
            e.target.value.toLowerCase().trim();

        const rows =
            document.querySelectorAll('#productTableBody .product-row');

        rows.forEach(function(row) {

            const text =
                row.innerText.toLowerCase();

            row.style.display =
                text.includes(term) ? '' : 'none';

        });

    });

}

function selectCategory(categoryName)
{

    const label =
        document.getElementById('selectedCategoryLabel');

    if (label) {

        label.innerText = categoryName;

    }

    const rows =
        document.querySelectorAll('#productTableBody .product-row');

    rows.forEach(function(row)
    {

        const rowCategory =
            row.getAttribute('data-category');

        if (categoryName === 'All Categories')
        {

            row.style.display = '';

        }
        else
        {

            row.style.display =
                rowCategory === categoryName ? '' : 'none';

        }

    });

}

const logOutBtn =
    document.getElementById('logOutBtn');

if (logOutBtn) {

    logOutBtn.addEventListener('click', function()
    {

        if (confirm('Are you sure you want to log out?'))
        {

            window.location.href = 'index.html';

        }

    });

}

</script>

</body>

</html>
