<%@ page language="java"
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@ page import="com.entity.Product" %>

<%
Product product = (Product) request.getAttribute("product");
%>

<!DOCTYPE html>

<html lang="en">

<head>

<meta charset="utf-8"/>

<meta name="viewport" content="width=device-width, initial-scale=1.0"/>

<title>Quick Shop - Update Product Page</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet"/>

<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"
      rel="stylesheet"/>

<style>

:root {
    --amazon-dark: #131921;
    --amazon-nav-belt: #232f3e;
    --amazon-accent: #ff9900;
    --amazon-accent-hover: #e88b00;
    --amazon-btn-grad-start: #f7dfa5;
    --amazon-btn-grad-end: #f0c14b;
    --amazon-btn-border: #a88734;
    --amazon-btn-hover: #eeb933;
    --amazon-bg: #eaeded;
    --amazon-border: #d5d9d9;
    --amazon-focus: #e77600;
}

* {
    box-sizing: border-box;
}

html,
body {
    width: 100%;
    min-height: 100%;
    margin: 0;
    padding: 0;
}

body {
    background-color: var(--amazon-bg);
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI",
                 Roboto, "Helvetica Neue", Arial, sans-serif;
    color: #0f1111;
    min-height: 100vh;
    display: flex;
    flex-direction: column;
    overflow-x: hidden;
}

/* ================= HEADER ================= */

.admin-navbar {
    width: 100%;
    background-color: var(--amazon-dark);
    border-bottom: 3px solid var(--amazon-accent);
}

.navbar-inner {
    width: 100%;
    min-height: 62px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 20px;
}

.navbar-brand-area {
    min-width: 0;
    display: flex;
    align-items: center;
    gap: 10px;
}

.brand-link {
    display: inline-flex;
    align-items: center;
    color: #ffffff;
    text-decoration: none;
    min-width: 0;
}

.brand-link:hover {
    color: #ffffff;
}

.brand-icon {
    color: var(--amazon-accent);
    font-size: 1.8rem;
    margin-right: 8px;
    flex-shrink: 0;
}

.brand-logo-text {
    font-size: 1.35rem;
    font-weight: 700;
    letter-spacing: -0.5px;
    color: #ffffff;
    white-space: nowrap;
}

.badge-admin {
    background-color: var(--amazon-accent);
    color: #111111;
    font-weight: 700;
    font-size: 0.7rem;
    padding: 5px 8px;
    border-radius: 4px;
    white-space: nowrap;
}

.dashboard-link {
    min-height: 36px;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 7px;
    padding: 6px 13px;
    border: 1px solid #677788;
    border-radius: 6px;
    color: #ffffff;
    text-decoration: none;
    font-size: 0.78rem;
    font-weight: 600;
    white-space: nowrap;
    transition: 0.2s ease;
}

.dashboard-link:hover {
    background: #febd69;
    border-color: #febd69;
    color: #111111;
}

.dashboard-link i {
    font-size: 0.9rem;
}

/* ================= MAIN ================= */

.page-container {
    width: 100%;
    max-width: 980px;
    margin: 0 auto;
    padding: 28px 20px 40px;
    flex: 1;
}

/* ================= BREADCRUMB ================= */

.qs-breadcrumb {
    font-size: 0.84rem;
    margin-bottom: 18px;
}

.qs-breadcrumb a {
    color: #007185;
    text-decoration: none;
}

.qs-breadcrumb a:hover {
    color: #c7511f;
    text-decoration: underline;
}

/* ================= PAGE TITLE ================= */

.page-title-area {
    display: flex;
    flex-direction: column;
    gap: 4px;
    padding-bottom: 18px;
    margin-bottom: 22px;
    border-bottom: 1px solid #c7c9c9;
}

.page-title {
    margin: 0;
    color: #131921;
    font-size: 1.65rem;
    font-weight: 700;
    line-height: 1.3;
}

.page-description {
    margin: 0;
    color: #5f6363;
    font-size: 0.84rem;
    line-height: 1.5;
}

/* ================= FORM CARD ================= */

.form-section-card {
    width: 100%;
    background: #ffffff;
    border: 1px solid var(--amazon-border);
    border-radius: 10px;
    box-shadow: 0 4px 16px rgba(0, 0, 0, 0.07);
    padding: 36px;
}

/* ================= FORM ================= */

.form-label {
    display: block;
    font-weight: 600;
    font-size: 0.88rem;
    color: #232f3e;
    margin-bottom: 7px;
}

.input-group {
    width: 100%;
    display: flex;
}

.input-group-text {
    min-width: 46px;
    height: 45px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: #f3f3f3;
    border-color: #888c8c;
    color: #565959;
    flex-shrink: 0;
}

.form-control,
.form-select {
    min-height: 45px;
    border: 1px solid #888c8c;
    border-radius: 0 5px 5px 0;
    padding: 0.65rem 0.85rem;
    font-size: 0.9rem;
    box-shadow: none;
    min-width: 0;
    transition: border-color 0.15s ease,
                box-shadow 0.15s ease;
}

.form-select {
    border-radius: 0 5px 5px 0;
}

.form-control:focus,
.form-select:focus {
    border-color: var(--amazon-focus);
    outline: 0;
    box-shadow: 0 0 0 3px rgba(231, 118, 0, 0.20);
}

.form-control::placeholder {
    color: #8a8d8d;
}

/* ================= IMAGE PREVIEW ================= */

.image-preview-box {
    width: 100%;
    min-height: 106px;
    border: 1px solid #d5d9d9;
    border-radius: 7px;
    background: #fcfcfc;
    padding: 14px;
    transition: 0.2s ease;
}

.image-preview-box:hover {
    border-color: var(--amazon-accent);
    background: #fffcf8;
}

.image-preview-content {
    width: 100%;
    display: flex;
    align-items: center;
    gap: 14px;
}

.image-preview {
    width: 72px;
    height: 72px;
    min-width: 72px;
    border: 1px solid #d5d9d9;
    border-radius: 6px;
    background: #ffffff;
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
    position: relative;
}

.image-preview img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.image-preview-icon {
    font-size: 2rem;
    color: #8b9292;
}

.current-badge {
    position: absolute;
    bottom: 3px;
    left: 50%;
    transform: translateX(-50%);
    background: #212529;
    color: #ffffff;
    font-size: 0.58rem;
    padding: 2px 6px;
    border-radius: 20px;
    white-space: nowrap;
    opacity: 0.9;
}

.image-details {
    min-width: 0;
    flex: 1;
}

.image-change-row {
    display: flex;
    align-items: center;
    gap: 8px;
    flex-wrap: wrap;
}

.change-image-btn {
    min-height: 34px;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 5px;
    padding: 5px 12px;
    border: 1px solid #8b9292;
    border-radius: 5px;
    background: #ffffff;
    color: #333333;
    font-size: 0.76rem;
    font-weight: 600;
    cursor: pointer;
}

.change-image-btn:hover {
    background: #f3f3f3;
    border-color: #555555;
}

.field-hint {
    margin-top: 5px;
    color: #565959;
    font-size: 0.72rem;
    line-height: 1.4;
}

/* ================= BUTTONS ================= */

.btn-amazon-primary {
    min-height: 44px;
    background: linear-gradient(
        to bottom,
        var(--amazon-btn-grad-start),
        var(--amazon-btn-grad-end)
    );
    border: 1px solid var(--amazon-btn-border);
    color: #111111;
    font-weight: 600;
    font-size: 0.88rem;
    padding: 8px 22px;
    border-radius: 7px;
    box-shadow: 0 2px 5px rgba(213, 217, 217, 0.5);
    transition: 0.15s ease;
}

.btn-amazon-primary:hover {
    background: linear-gradient(
        to bottom,
        #f5d78e,
        var(--amazon-btn-hover)
    );
    border-color: #846a29;
    color: #000000;
}

.btn-amazon-secondary {
    min-height: 44px;
    background: #ffffff;
    border: 1px solid #a6a6a6;
    color: #0f1111;
    font-weight: 500;
    font-size: 0.88rem;
    padding: 8px 22px;
    border-radius: 7px;
    box-shadow: 0 2px 5px rgba(213, 217, 217, 0.5);
    text-decoration: none;
    transition: 0.15s ease;
}

.btn-amazon-secondary:hover {
    background-color: #f7fafa;
    border-color: #777777;
    color: #111111;
}

/* ================= FORM ACTIONS ================= */

.form-actions {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 15px;
    padding-top: 22px;
    margin-top: 24px;
    border-top: 1px solid #e0e2e2;
}

.form-actions-left,
.form-actions-right {
    display: flex;
    align-items: center;
    gap: 10px;
}

/* ================= FOOTER ================= */

.footer-bar {
    width: 100%;
    background-color: var(--amazon-dark);
    color: #999999;
    font-size: 0.78rem;
    padding: 17px 10px;
    margin-top: auto;
    text-align: center;
}

.footer-bar p {
    margin: 0;
    color: #dddddd;
}

/* ================= TABLET ================= */

@media (max-width: 991.98px) {

    .page-container {
        max-width: 900px;
        padding: 25px 18px 35px;
    }

    .form-section-card {
        padding: 30px;
    }

    .page-title {
        font-size: 1.5rem;
    }

}

/* ================= SMALL TABLET ================= */

@media (max-width: 767.98px) {

    .admin-navbar {
        border-bottom-width: 2px;
    }

    .navbar-inner {
        min-height: auto;
        padding: 10px 12px;
        flex-wrap: wrap;
        gap: 10px;
    }

    .navbar-brand-area {
        width: 100%;
        justify-content: space-between;
    }

    .brand-logo-text {
        font-size: 1.18rem;
    }

    .brand-icon {
        font-size: 1.5rem;
        margin-right: 6px;
    }

    .badge-admin {
        font-size: 0.62rem;
        padding: 5px 8px;
    }

    .dashboard-wrapper {
        width: 100%;
    }

    .dashboard-link {
        width: 100%;
        min-height: 38px;
        font-size: 0.74rem;
    }

    .page-container {
        padding: 18px 12px 25px;
    }

    .qs-breadcrumb {
        font-size: 0.76rem;
        margin-bottom: 14px;
    }

    .page-title-area {
        padding-bottom: 15px;
        margin-bottom: 17px;
    }

    .page-title {
        font-size: 1.3rem;
    }

    .page-description {
        font-size: 0.76rem;
        line-height: 1.45;
    }

    .form-section-card {
        padding: 21px 15px;
        border-radius: 8px;
    }

    .form-label {
        font-size: 0.82rem;
        margin-bottom: 6px;
    }

    .form-control,
    .form-select {
        min-height: 43px;
        font-size: 0.84rem;
        padding: 0.6rem 0.7rem;
    }

    .input-group-text {
        min-width: 42px;
        height: 43px;
        padding: 0 10px;
    }

    .form-section-card .row {
        --bs-gutter-y: 1.15rem;
    }

    .image-preview-box {
        padding: 11px;
    }

    .image-preview-content {
        gap: 10px;
    }

    .image-preview {
        width: 62px;
        height: 62px;
        min-width: 62px;
    }

    .image-change-row {
        gap: 6px;
    }

    .change-image-btn {
        font-size: 0.7rem;
        padding: 5px 9px;
    }

    .field-hint {
        font-size: 0.67rem;
    }

    .form-actions {
        flex-direction: column-reverse;
        align-items: stretch;
        gap: 10px;
    }

    .form-actions-left,
    .form-actions-right {
        width: 100%;
    }

    .form-actions .btn-amazon-primary,
    .form-actions .btn-amazon-secondary {
        width: 100%;
        min-height: 44px;
    }

    .footer-bar {
        padding: 14px 8px;
        font-size: 0.7rem;
    }

}

/* ================= SMALL MOBILE ================= */

@media (max-width: 480px) {

    .navbar-inner {
        padding: 9px 10px;
    }

    .brand-logo-text {
        font-size: 1.05rem;
    }

    .brand-icon {
        font-size: 1.35rem;
        margin-right: 5px;
    }

    .badge-admin {
        font-size: 0.58rem;
        padding: 4px 7px;
    }

    .page-container {
        padding: 13px 8px 20px;
    }

    .qs-breadcrumb {
        font-size: 0.7rem;
    }

    .page-title {
        font-size: 1.15rem;
    }

    .page-description {
        font-size: 0.7rem;
    }

    .form-section-card {
        padding: 17px 11px;
    }

    .form-label {
        font-size: 0.78rem;
    }

    .form-control,
    .form-select {
        font-size: 0.8rem;
        min-height: 42px;
    }

    .input-group-text {
        min-width: 39px;
        height: 42px;
        font-size: 0.85rem;
        padding: 0 8px;
    }

    .image-preview-box {
        padding: 9px;
    }

    .image-preview-content {
        gap: 8px;
    }

    .image-preview {
        width: 56px;
        height: 56px;
        min-width: 56px;
    }

    .image-preview-icon {
        font-size: 1.5rem;
    }

    .current-badge {
        font-size: 0.5rem;
        padding: 1px 5px;
    }

    .change-image-btn {
        font-size: 0.66rem;
        padding: 4px 7px;
    }

    .field-hint {
        font-size: 0.62rem;
    }

    .btn-amazon-primary,
    .btn-amazon-secondary {
        font-size: 0.8rem;
        padding: 8px 14px;
    }

}

/* ================= VERY SMALL MOBILE ================= */

@media (max-width: 360px) {

    .brand-logo-text {
        font-size: 0.98rem;
    }

    .brand-icon {
        font-size: 1.2rem;
    }

    .page-container {
        padding-left: 6px;
        padding-right: 6px;
    }

    .form-section-card {
        padding: 15px 9px;
    }

    .page-title {
        font-size: 1.05rem;
    }

    .page-description {
        font-size: 0.66rem;
    }

    .image-preview {
        width: 52px;
        height: 52px;
        min-width: 52px;
    }

    .image-preview-content {
        gap: 7px;
    }

    .change-image-btn span {
        display: none;
    }

    .change-image-btn {
        width: 34px;
        height: 32px;
        padding: 0;
    }

    .change-image-btn i {
        margin: 0;
    }

}

/* ================= PREVENT INPUT OVERFLOW ================= */

.input-group > .form-control,
.input-group > .form-select {
    min-width: 0;
    flex: 1 1 auto;
}

</style>

</head>

<body>

<!-- ================= HEADER ================= -->

<header class="admin-navbar">

    <div class="container-fluid">

        <div class="navbar-inner">

            <div class="navbar-brand-area">

                <a class="brand-link" href="adminDashboard.jsp">

                    <i class="bi bi-cart3 brand-icon"></i>

                    <span class="brand-logo-text">
                        Quick Shop
                    </span>

                </a>

                <span class="badge badge-admin text-uppercase">
                    Admin
                </span>

            </div>

            <div class="dashboard-wrapper">

                <a class="dashboard-link"
                   href="viewProduct">

                    <i class="bi bi-arrow-left-circle"></i>

                    <span>
                        Back to Dashboard
                    </span>

                </a>

            </div>

        </div>

    </div>

</header>

<!-- ================= MAIN ================= -->

<main class="page-container">

    <!-- BREADCRUMB -->

    <nav aria-label="breadcrumb">

        <ol class="breadcrumb qs-breadcrumb">

            <li class="breadcrumb-item">

                <a href="adminDashboard.jsp">

                    <i class="bi bi-house-door me-1"></i>

                    Dashboard

                </a>

            </li>

            <li class="breadcrumb-item active text-secondary"
                aria-current="page">

                Update Product

            </li>

        </ol>

    </nav>

    <!-- PAGE TITLE -->

    <div class="page-title-area">

        <h1 class="page-title">
            Update Product
        </h1>

        <p class="page-description">

            Edit product specifications, pricing, stock levels,
            or media for existing inventory items.

        </p>

    </div>

    <!-- ================= FORM CARD ================= -->

    <div class="form-section-card">

        <form id="updateProductForm"
              action="updateProduct"
              method="post"
              enctype="multipart/form-data">

            <!-- PRODUCT ID -->

            <input type="hidden"
                   name="productId"
                   value="<%= product.getProductId() %>">

            <!-- PRODUCT NAME -->

            <div class="mb-4">

                <label class="form-label"
                       for="productName">

                    Product Name
                    <span class="text-danger">*</span>

                </label>

                <div class="input-group">

                    <span class="input-group-text">

                        <i class="bi bi-tag"></i>

                    </span>

                    <input class="form-control"
                           id="productName"
                           name="productName"
                           placeholder="Enter full product name or title"
                           required
                           type="text"
                           value="<%= product.getProductName() %>">

                </div>

            </div>

            <!-- CATEGORY / PRICE / QUANTITY / IMAGE -->

            <div class="row g-4">

                <!-- CATEGORY -->

                <div class="col-12 col-md-6">

                    <label class="form-label"
                           for="productCategory">

                        Category
                        <span class="text-danger">*</span>

                    </label>

                    <div class="input-group">

                        <span class="input-group-text">

                            <i class="bi bi-grid-3x3-gap"></i>

                        </span>

                        <select class="form-select"
                                id="productCategory"
                                name="category"
                                required>

                            <option value="">
                                Select a store category
                            </option>

                            <option value="electronics"
                                    <%= "electronics".equalsIgnoreCase(product.getCategory()) ? "selected" : "" %>>
                                Electronics
                            </option>

                            <option value="computers"
                                    <%= "computers".equalsIgnoreCase(product.getCategory()) ? "selected" : "" %>>
                                Computers & Accessories
                            </option>

                            <option value="home"
                                    <%= "home".equalsIgnoreCase(product.getCategory()) ? "selected" : "" %>>
                                Home & Kitchen
                            </option>

                            <option value="books"
                                    <%= "books".equalsIgnoreCase(product.getCategory()) ? "selected" : "" %>>
                                Books & Media
                            </option>

                            <option value="fashion"
                                    <%= "fashion".equalsIgnoreCase(product.getCategory()) ? "selected" : "" %>>
                                Fashion & Apparel
                            </option>

                            <option value="sports"
                                    <%= "sports".equalsIgnoreCase(product.getCategory()) ? "selected" : "" %>>
                                Sports & Outdoors
                            </option>

                            <option value="beauty"
                                    <%= "beauty".equalsIgnoreCase(product.getCategory()) ? "selected" : "" %>>
                                Beauty & Personal Care
                            </option>

                        </select>

                    </div>

                </div>

                <!-- PRICE -->

                <div class="col-12 col-md-6">

                    <label class="form-label"
                           for="productPrice">

                        Product Price
                        <span class="text-danger">*</span>

                    </label>

                    <div class="input-group">

                        <span class="input-group-text fw-bold">

                            ₹

                        </span>

                        <input class="form-control"
                               id="productPrice"
                               min="0"
                               name="productPrice"
                               placeholder="0.00"
                               required
                               step="0.01"
                               type="number"
                               value="<%= product.getProductPrice() %>">

                    </div>

                </div>

                <!-- QUANTITY -->

                <div class="col-12 col-md-6">

                    <label class="form-label"
                           for="productQuantity">

                        Product Quantity
                        <span class="text-danger">*</span>

                    </label>

                    <div class="input-group">

                        <span class="input-group-text">

                            <i class="bi bi-boxes"></i>

                        </span>

                        <input class="form-control"
                               id="productQuantity"
                               min="0"
                               name="productQty"
                               placeholder="e.g. 50"
                               required
                               step="1"
                               type="number"
                               value="<%= product.getProductQty() %>">

                    </div>

                </div>

                <!-- PRODUCT IMAGE -->

                <div class="col-12 col-md-6">

                    <label class="form-label">

                        Product Image

                    </label>

                    <div class="image-preview-box">

                        <div class="image-preview-content">

                            <!-- IMAGE -->

                            <div class="image-preview">

                                <% if (product.getImage() != null
                                    && !product.getImage().isEmpty()) { %>

                                    <img src="<%= request.getContextPath() %>/images/<%= product.getImage() %>"
                                         alt="<%= product.getImage() %>"
                                         id="imagePreviewImg">

                                <% } else { %>

                                    <i class="bi bi-image image-preview-icon"
                                       id="defaultIconPreview"></i>

                                <% } %>

                                <span class="current-badge">
                                    Current
                                </span>

                            </div>

                            <!-- IMAGE DETAILS -->

                            <div class="image-details">

                                <div class="image-change-row">

                                    <label class="change-image-btn"
                                           for="productImageInput">

                                        <i class="bi bi-upload"></i>

                                        <span>
                                            Change Image
                                        </span>

                                    </label>

                                    <input accept="image/jpeg, image/png, image/webp"
                                           class="d-none"
                                           id="productImageInput"
                                           name="productImage"
                                           onchange="handleImageChange(this)"
                                           type="file">

                                </div>

                                <div class="field-hint">

                                    Supported formats:
                                    JPG, PNG, WEBP

                                </div>

                            </div>

                        </div>

                    </div>

                </div>

            </div>

            <!-- ================= ACTION BUTTONS ================= -->

            <div class="form-actions">

                <div class="form-actions-left">

                    <a class="btn btn-amazon-secondary
                              d-inline-flex
                              align-items-center
                              justify-content-center
                              gap-2"
                       href="viewProduct">

                        <i class="bi bi-arrow-left"></i>

                        <span>
                            Back
                        </span>

                    </a>

                </div>

                <div class="form-actions-right">

                    <button class="btn btn-amazon-primary
                                   d-inline-flex
                                   align-items-center
                                   justify-content-center
                                   gap-2"
                            type="submit">

                        <i class="bi bi-arrow-repeat"></i>

                        <span>
                            Update Product
                        </span>

                    </button>

                </div>

            </div>

        </form>

    </div>

</main>

<!-- ================= FOOTER ================= -->

<footer class="footer-bar">

    <p>
        © 2026 QuickShop.com
    </p>

</footer>

<!-- ================= SCRIPT ================= -->

<script>

function handleImageChange(input)
{
    const previewImg =
        document.getElementById('imagePreviewImg');

    if (input.files && input.files[0])
    {
        const file = input.files[0];

        const reader = new FileReader();

        reader.onload = function(e)
        {
            if (previewImg)
            {
                previewImg.src = e.target.result;
            }
            else
            {
                const container =
                    document.querySelector('.image-preview');

                const icon =
                    document.getElementById('defaultIconPreview');

                if (icon)
                {
                    icon.remove();
                }

                const newImg =
                    document.createElement('img');

                newImg.id = 'imagePreviewImg';

                newImg.src = e.target.result;

                newImg.alt = 'Product Image';

                container.prepend(newImg);
            }
        };

        reader.readAsDataURL(file);
    }
}

</script>

</body>

</html>