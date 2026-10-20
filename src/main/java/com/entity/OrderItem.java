
package com.entity;

import java.math.BigDecimal;

public class OrderItem {

    private String productId;
    private String productName;
    private String image;
    private int quantity;
    private BigDecimal price;

    public OrderItem() {
    }

    public OrderItem(String productId, String productName,
                     int quantity, BigDecimal price) {
        this.productId = productId;
        this.productName = productName;
        this.quantity = quantity;
        this.price = price;
    }

    public OrderItem(String productId, String productName,
                     int quantity, BigDecimal price, String image) {
        this.productId = productId;
        this.productName = productName;
        this.quantity = quantity;
        this.price = price;
        this.image = image;
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public BigDecimal getSubtotal() {
        if (price == null) {
            return BigDecimal.ZERO;
        }

        return price.multiply(BigDecimal.valueOf(quantity));
    }
}
