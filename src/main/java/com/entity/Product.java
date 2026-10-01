package com.entity;

import java.io.Serializable;

public class Product implements Serializable
{
    private String productId;
    private String productName;
    private String category;
    private double productPrice;
    private int productQty;
    private String image;

    public Product()
    {
        super();
    }

    public Product(String productId, String productName, String category, double productPrice, int productQty, String image) {
        this.productId = productId;
        this.productName = productName;
        this.category = category;
        this.productPrice = productPrice;
        this.productQty = productQty;
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

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public double getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(double productPrice) {
        this.productPrice = productPrice;
    }

    public int getProductQty() {
        return productQty;
    }

    public void setProductQty(int productQty) {
        this.productQty = productQty;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }
}
