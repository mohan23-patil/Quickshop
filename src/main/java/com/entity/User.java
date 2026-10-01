package com.entity;

import java.io.Serializable;

public class User implements Serializable
{
    private String userId;
    private String fullName;
    private String emailId;
    private long mobileNo;
    private String password;
    private String address;
    private String city;
    private String state;
    private int pincode;

    public User()
    {
        super();
    }

    public User(String userId, String fullName, String emailId, long mobileNo, String password, String address, String city, String state, int pincode) {
        this.userId = userId;
        this.fullName = fullName;
        this.emailId = emailId;
        this.mobileNo = mobileNo;
        this.password = password;
        this.address = address;
        this.city = city;
        this.state = state;
        this.pincode = pincode;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmailId() {
        return emailId;
    }

    public void setEmailId(String emailId) {
        this.emailId = emailId;
    }

    public long getMobileNo() {
        return mobileNo;
    }

    public void setMobileNo(long mobileNo) {
        this.mobileNo = mobileNo;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public int getPincode() {
        return pincode;
    }

    public void setPincode(int pincode) {
        this.pincode = pincode;
    }
}
