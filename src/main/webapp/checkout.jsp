<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.entity.CheckoutItem" %>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    List<CheckoutItem> checkoutItems =
            (List<CheckoutItem>) request.getAttribute("checkoutItems");
    BigDecimal cartTotal = (BigDecimal) request.getAttribute("cartTotal");
    if (cartTotal == null) cartTotal = BigDecimal.ZERO;
    if (checkoutItems == null) checkoutItems = java.util.Collections.emptyList();
    String checkoutMessage = request.getParameter("message");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QuickShop - Checkout</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        :root {
            --qs-navy-dark: #131921;
            --qs-navy-medium: #232f3e;
            --qs-amber-light: #febd69;
            --qs-amber-main: #f3a847;
            --qs-yellow-btn: #ffd814;
            --qs-yellow-hover: #f7ca00;
            --qs-bg-neutral: #eaeded;
            --qs-text-primary: #0f1111;
            --qs-text-muted: #565959;
            --qs-border-color: #d5d9d9;
        }
        *, *::before, *::after { box-sizing: border-box; }
        html { width: 100%; overflow-x: hidden; }
        body {
            margin: 0; min-height: 100vh; width: 100%; overflow-x: hidden;
            display: flex; flex-direction: column;
            background: var(--qs-bg-neutral); color: var(--qs-text-primary);
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Arial, sans-serif;
        }
        img { max-width: 100%; }
        .qs-navbar { background: var(--qs-navy-dark); border-bottom: 2px solid var(--qs-amber-light); }
        .qs-logo-brand {
            display: inline-flex; align-items: center; gap: .35rem; color: #fff;
            font-weight: 700; font-size: 1.5rem; letter-spacing: -.5px; text-decoration: none;
        }
        .qs-logo-brand:hover { color: #fff; }
        .qs-logo-brand .highlight { color: var(--qs-amber-light); }
        .qs-nav-link { color: #d1d5db; font-size: .875rem; text-decoration: none; }
        .qs-nav-link:hover { color: var(--qs-amber-light); }
        .qs-footer { background: var(--qs-navy-dark); color: #9ca3af; font-size: .8125rem; border-top: 1px solid #374151; }
        .qs-footer a { color: #d1d5db; text-decoration: none; margin: 0 .45rem; }
        .qs-footer a:hover { color: var(--qs-amber-light); text-decoration: underline; }
        .checkout-container { width: 100%; max-width: 1440px; margin: 0 auto; }
        .checkout-card { border: 1px solid #d5d9d9; border-radius: 10px; box-shadow: 0 2px 8px rgba(0,0,0,.05); }
        .checkout-card .card-header { background: #fff; }
        .btn-qs {
            background: linear-gradient(to bottom, #ffd814, #f7ca00); border: 1px solid #fcd200;
            color: #0f1111; font-weight: 650; border-radius: 999px; padding: .7rem 1rem;
            box-shadow: 0 1px 2px rgba(0,0,0,.12);
        }
        .btn-qs:hover { background: linear-gradient(to bottom, #f7ca00, #f0b800); color: #0f1111; }
        .form-control, .form-select { border-color: #888c8c; border-radius: 6px; min-height: 42px; }
        .form-control:focus, .form-select:focus { border-color: #e77600; box-shadow: 0 0 0 3px rgba(228,121,17,.2); }
        .form-label { font-size: .875rem; font-weight: 600; margin-bottom: .35rem; }
        .product-image-wrap { width: 84px; height: 84px; flex: 0 0 84px; }
        .product-image-wrap img { width: 100%; height: 100%; object-fit: contain; }
        .product-name { overflow-wrap: anywhere; }
        .order-summary { position: sticky; top: 1rem; }
        .muted-small { font-size: .78rem; color: var(--qs-text-muted); }
        .payment-option { border: 1px solid var(--qs-border-color); border-radius: 9px; padding: 1rem; }
        .payment-option:has(input:checked) { border-color: #f3a847; background: #fffaf0; }
        .legal-disclaimer { font-size: .74rem; line-height: 1.45; color: var(--qs-text-muted); }
        .legal-disclaimer a { color: #007185; text-decoration: none; }
        @media (max-width: 991.98px) {
            .order-summary { position: static; }
            .checkout-container { max-width: 800px; }
        }
        @media (max-width: 575.98px) {
            .qs-logo-brand { font-size: 1.25rem; }
            main { padding-top: 1rem !important; padding-bottom: 1rem !important; }
            .checkout-container { padding-left: .65rem !important; padding-right: .65rem !important; }
            .card-header, .card-body { padding-left: .85rem !important; padding-right: .85rem !important; }
            .checkout-heading { font-size: 1.35rem; }
            .product-image-wrap { width: 68px; height: 68px; flex-basis: 68px; }
            .product-row { gap: .7rem !important; }
            .product-row .product-name { font-size: .92rem; }
            .footer-links a { display: inline-block; margin: .25rem .35rem; }
            .secure-row { align-items: flex-start !important; }
            .btn-qs { min-height: 46px; width: 100%; }
        }
        @media (prefers-reduced-motion: reduce) { *, *::before, *::after { animation-duration: .01ms !important; transition-duration: .01ms !important; } }
    </style>
</head>
<body>
<header class="qs-navbar py-2 px-3">
    <div class="container-fluid d-flex flex-wrap align-items-center justify-content-between gap-2">
        <a class="qs-logo-brand" href="<%= request.getContextPath() %>/userViewAllProduct" title="QuickShop Home">
            <i class="bi bi-cart3 text-warning fs-3"></i>
            <span>Quick<span class="highlight">Shop</span></span>
        </a>
        <div class="d-none d-md-flex align-items-center gap-4">
            <a class="qs-nav-link" href="#support"><i class="bi bi-headset me-1 text-warning"></i>Customer Support</a>
            <span class="qs-nav-link"><i class="bi bi-shield-check me-1 text-warning"></i>Secure Checkout</span>
        </div>
    </div>
</header>

<main class="flex-grow-1 py-4 py-lg-5">
    <div class="checkout-container px-3 px-md-4">
        <div class="row align-items-center mb-3 pb-3 border-bottom border-secondary border-opacity-25 g-2">
            <div class="col-12 col-md-5 d-flex align-items-center gap-2">
                <h1 class="checkout-heading fs-4 fw-bold mb-0">Checkout</h1>
                <span class="text-secondary small">(<%= checkoutItems.size() %> <%= checkoutItems.size() == 1 ? "item" : "items" %>)</span>
            </div>
            <div class="col-12 col-md-7 d-flex flex-wrap justify-content-md-end align-items-center gap-3 small secure-row">
                <span class="d-inline-flex align-items-center text-success"><i class="bi bi-shield-lock-fill fs-5 me-1"></i>Secure checkout</span>
                <span class="d-inline-flex align-items-center text-muted"><i class="bi bi-headset me-1 text-warning fs-5"></i>Need help? Contact support</span>
            </div>
        </div>

        <% if ("empty".equals(checkoutMessage)) { %>
            <div class="alert alert-info">Your cart is empty. Add products before checkout.</div>
        <% } %>

        <% if (checkoutItems.isEmpty()) { %>
            <div class="card checkout-card p-4 text-center">
                <i class="bi bi-cart-x display-4 text-secondary mb-2"></i>
                <h2 class="h5">Your cart is empty</h2>
                <p class="text-secondary">Add a product to your cart to continue to checkout.</p>
                <a class="btn btn-qs align-self-center" href="<%= request.getContextPath() %>/userViewAllProduct">Continue shopping</a>
            </div>
        <% } else { %>
        <div class="row g-4 align-items-start">
            <div class="col-12 col-lg-8">
                <!-- Delivery address -->
                <section class="card checkout-card mb-3 overflow-hidden" id="step-address">
                    <div class="card-header border-0 py-3 px-3 px-md-4 d-flex align-items-center gap-2">
                        <span class="badge bg-dark rounded-circle p-2">1</span>
                        <h2 class="h5 fw-bold mb-0">Delivery Address</h2>
                    </div>
                    <div class="card-body px-3 px-md-4 pt-1 pb-4">
                        <div class="rounded-2 bg-light border border-warning p-3 mb-3">
                            <div class="d-flex flex-wrap justify-content-between align-items-center gap-2 mb-1">
                                <span class="fw-bold"><i class="bi bi-person-circle me-1"></i><%= username %></span>
                                <span class="badge text-bg-warning">Logged-in customer</span>
                            </div>
                            <div class="small text-secondary">Enter the delivery details for this order below.</div>
                        </div>
                        <form id="checkoutForm" action="<%= request.getContextPath() %>/placeOrder" method="post">
                            <div class="row g-3">
                                <div class="col-12 col-md-6">
                                    <label class="form-label" for="fullName">Full name</label>
                                    <input class="form-control" id="fullName" name="fullName" type="text" autocomplete="name" maxlength="100" required placeholder="Enter recipient name">
                                </div>
                                <div class="col-12 col-md-6">
                                    <label class="form-label" for="phone">Mobile number</label>
                                    <input class="form-control" id="phone" name="phone" type="tel" inputmode="numeric" autocomplete="tel" pattern="[0-9]{10}" maxlength="10" required placeholder="10-digit mobile number">
                                </div>
                                <div class="col-12">
                                    <label class="form-label" for="address">Full address</label>
                                    <textarea class="form-control" id="address" name="address" rows="3" maxlength="500" autocomplete="street-address" required placeholder="House/flat, street, area, landmark"></textarea>
                                </div>
                                <div class="col-12 col-md-6">
                                    <label class="form-label" for="city">City</label>
                                    <input class="form-control" id="city" name="city" type="text" maxlength="80" autocomplete="address-level2" required placeholder="City">
                                </div>
                                <div class="col-12 col-md-6">
                                    <label class="form-label" for="state">State</label>
                                    <input class="form-control" id="state" name="state" type="text" maxlength="80" autocomplete="address-level1" required placeholder="State">
                                </div>
                                <div class="col-12 col-md-6">
                                    <label class="form-label" for="pincode">PIN code</label>
                                    <input class="form-control" id="pincode" name="pincode" type="text" inputmode="numeric" pattern="[0-9]{6}" maxlength="6" autocomplete="postal-code" required placeholder="6-digit PIN code">
                                </div>
                            </div>
                        </form>
                    </div>
                </section>

                <!-- Payment method -->
                <section class="card checkout-card mb-3 overflow-hidden" id="step-payment">
                    <div class="card-header border-0 py-3 px-3 px-md-4 d-flex justify-content-between align-items-center gap-2">
                        <div class="d-flex align-items-center gap-2"><span class="badge bg-dark rounded-circle p-2">2</span><h2 class="h5 fw-bold mb-0">Payment Method</h2></div>
                        <span class="small text-success"><i class="bi bi-shield-check me-1"></i>Protected</span>
                    </div>
                    <div class="card-body px-3 px-md-4 pt-1 pb-4">
                        <div class="payment-option mb-3">
                            <div class="form-check">
                                <input class="form-check-input" id="paymentCod" name="paymentOption" value="COD" type="radio" form="checkoutForm" required>
                                <label class="form-check-label w-100" for="paymentCod">
                                    <span class="fw-semibold">Cash on Delivery</span><i class="bi bi-cash-stack float-end fs-5 text-secondary"></i>
                                    <span class="d-block small text-secondary mt-1">Pay when your order arrives.</span>
                                </label>
                            </div>
                        </div>
                        <div class="payment-option mb-3">
                            <div class="form-check">
                                <input class="form-check-input" id="paymentUpi" name="paymentOption" value="UPI" type="radio" form="checkoutForm">
                                <label class="form-check-label w-100" for="paymentUpi">
                                    <span class="fw-semibold">UPI</span><i class="bi bi-phone float-end fs-5 text-secondary"></i>
                                    <span class="d-block small text-secondary mt-1">Google Pay, PhonePe, BHIM and supported UPI apps.</span>
                                </label>
                            </div>
                        </div>
                        <div class="payment-option">
                            <div class="form-check">
                                <input class="form-check-input" id="paymentCard" name="paymentOption" value="CARD" type="radio" form="checkoutForm">
                                <label class="form-check-label w-100" for="paymentCard">
                                    <span class="fw-semibold">Credit or Debit Card</span><i class="bi bi-credit-card-2-front float-end fs-5 text-secondary"></i>
                                    <span class="d-block small text-secondary mt-1">Card payments must be completed through a supported payment provider.</span>
                                </label>
                            </div>
                        </div>
                        <p class="muted-small mt-3 mb-0"><i class="bi bi-info-circle me-1"></i>Do not enter or store card number or CVV directly on this page.</p>
                    </div>
                </section>

                <!-- Review items -->
                <section class="card checkout-card mb-4 overflow-hidden" id="step-review">
                    <div class="card-header border-0 py-3 px-3 px-md-4 d-flex align-items-center gap-2">
                        <span class="badge bg-dark rounded-circle p-2">3</span><h2 class="h5 fw-bold mb-0">Review Items</h2>
                    </div>
                    <div class="card-body px-3 px-md-4 pt-1 pb-4">
                        <div class="alert alert-warning py-2 small"><i class="bi bi-truck me-2"></i>Review your products and quantities before continuing.</div>
                        <div class="d-flex flex-column gap-3">
                            <% for (CheckoutItem item : checkoutItems) { %>
                                <div class="product-row d-flex gap-3 pb-3 border-bottom align-items-start">
                                    <div class="product-image-wrap rounded-2 p-2 bg-white border d-flex align-items-center justify-content-center">
                                        <%
                                            String imageUrl = item.getImage();

                                            if (imageUrl != null && !imageUrl.trim().isEmpty()) {
                                        %>
                                            <img
                                                src="<%= imageUrl %>"
                                                alt="Product image"
                                                class="img-fluid"
                                                onerror="this.onerror=null; this.src='https://placehold.co/100x100?text=No+Image';">
                                        <%
                                            } else {
                                        %>
                                            <img
                                                src="https://placehold.co/100x100?text=No+Image"
                                                alt="No product image"
                                                class="img-fluid">
                                        <%
                                            }
                                        %>
                                    </div>
                                    <div class="flex-grow-1 min-w-0">
                                        <div class="d-flex flex-wrap justify-content-between align-items-start gap-2">
                                            <h3 class="product-name h6 fw-bold mb-1">Cart item</h3>
                                            <span class="fw-bold text-dark text-nowrap">₹<%= item.getSubtotal().setScale(2, java.math.RoundingMode.HALF_UP) %></span>
                                        </div>
                                        <div class="small text-secondary">Item subtotal</div>
                                        <span class="small text-success"><i class="bi bi-check-circle me-1"></i>In your cart</span>
                                    </div>
                                </div>
                            <% } %>
                        </div>
                        <p class="muted-small mt-3 mb-0">Product details and final stock availability should be revalidated by the server when an order is submitted.</p>
                    </div>
                </section>
            </div>

            <!-- Order summary -->
            <aside class="col-12 col-lg-4">
                <div class="card checkout-card order-summary">
                    <div class="card-body p-3 p-md-4">
                        <button class="btn btn-qs w-100 mb-2" type="submit" form="checkoutForm">Continue to Place Order</button>
                        <p class="legal-disclaimer text-center mb-3">By continuing, you agree to QuickShop's <a href="#conditions">conditions of use</a> and <a href="#privacy">privacy notice</a>.</p>
                        <hr class="opacity-25">
                        <h2 class="h6 fw-bold mb-3">Order Summary</h2>
                        <div class="d-flex justify-content-between small text-secondary mb-2 gap-3"><span>Items (<%= checkoutItems.size() %>):</span><span class="text-dark fw-semibold text-nowrap">₹<%= cartTotal.setScale(2, java.math.RoundingMode.HALF_UP) %></span></div>
                        <div class="d-flex justify-content-between small text-secondary mb-2 gap-3"><span>Shipping &amp; handling:</span><span class="text-success fw-semibold">Calculated at order</span></div>
                        <div class="d-flex justify-content-between small text-secondary mb-2 gap-3"><span>Discount:</span><span>₹0.00</span></div>
                        <hr class="opacity-50">
                        <div class="d-flex justify-content-between align-items-baseline gap-2 mb-3">
                            <span class="h5 fw-bold mb-0">Order Total:</span>
                            <span class="h4 fw-bold mb-0 text-danger text-nowrap">₹<%= cartTotal.setScale(2, java.math.RoundingMode.HALF_UP) %></span>
                        </div>
                        <div class="rounded-2 bg-light border p-3 small">
                            <div class="d-flex align-items-center gap-2 mb-2"><i class="bi bi-shield-check text-success fs-5"></i><span class="fw-semibold">Shopping securely</span></div>
                            <div class="text-secondary">Your order should only be confirmed after the server has successfully created it.</div>
                        </div>
                        <div class="text-center mt-3"><a class="small text-secondary text-decoration-none" href="<%= request.getContextPath() %>/viewCart"><i class="bi bi-arrow-left me-1"></i>Return to cart</a></div>
                    </div>
                </div>
            </aside>
        </div>
        <% } %>
    </div>
</main>

<footer class="qs-footer py-3 mt-auto">
    <div class="container text-center">
        <div class="footer-links mb-2"><a href="#conditions">Conditions of Use</a><span class="text-secondary">|</span><a href="#privacy">Privacy Notice</a><span class="text-secondary">|</span><a href="#help">Help &amp; Customer Service</a></div>
        <p class="mb-0 text-secondary" style="font-size:.75rem">© 2026 QuickShop. All rights reserved.</p>
    </div>
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
