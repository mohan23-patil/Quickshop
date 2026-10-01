package com.entity;

import java.io.Serializable;

public class Admin implements Serializable
{
    private String adminName;
    private String password;
    private String fName;
    private String lName;
    private String emailId;
    private long mobileNo;

    public Admin()
    {
        super();
    }

    public Admin(String adminName, String password, String fName, String lName, String emailId, long mobileNo) {
        this.adminName = adminName;
        this.password = password;
        this.fName = fName;
        this.lName = lName;
        this.emailId = emailId;
        this.mobileNo = mobileNo;
    }

    public String getAdminName() {
        return adminName;
    }

    public void setAdminName(String adminName) {
        this.adminName = adminName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getfName() {
        return fName;
    }

    public void setfName(String fName) {
        this.fName = fName;
    }

    public String getlName() {
        return lName;
    }

    public void setlName(String lName) {
        this.lName = lName;
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
}
