package com.entity;

import java.math.BigDecimal;

public class CheckoutItem {

    private String productId;
    private String productName;
    private String image;
    private int quantity;
    private int availableQty;
    private BigDecimal price;

    public CheckoutItem(String productId, String productName,
                        String image, int quantity,
                        int availableQty, BigDecimal price) {
        this.productId = productId;
        this.productName = productName;
        this.image = image;
        this.quantity = quantity;
        this.availableQty = availableQty;
        this.price = price;
    }

    public String getProductId() {
        return productId;
    }

    public String getProductName() {
        return productName;
    }

    public String getImage() {
        return image;
    }

    public int getQuantity() {
        return quantity;
    }

    public int getAvailableQty() {
        return availableQty;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public BigDecimal getSubtotal() {
        return price.multiply(BigDecimal.valueOf(quantity));
    }
}