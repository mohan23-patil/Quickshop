package com.dao;

import com.dbConnection.DBConnection;
import com.entity.Admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class AdminDao
{
    public int adminRegistration(Admin admin)
    {
        int k = 0;
        try
        {
            Connection con = DBConnection.getConnection();
            PreparedStatement pstm = con.prepareStatement("insert into adminShopping values(?,?,?,?,?,?)");
            pstm.setString(1,admin.getAdminName());
            pstm.setString(2, admin.getPassword());
            pstm.setString(3, admin.getfName());
            pstm.setString(4, admin.getlName());
            pstm.setString(5,admin.getEmailId());
            pstm.setLong(6,admin.getMobileNo());
            k = pstm.executeUpdate();
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        return k;
    }

    public Admin adminLogin(String adminName,String password)
    {
        Admin admin = null;
        try
        {
            Connection con = DBConnection.getConnection();
            PreparedStatement pstm = con.prepareStatement("select * from adminShopping where adminName= ? and password = ?");
            pstm.setString(1,adminName);
            pstm.setString(2,password);
            ResultSet rs = pstm.executeQuery();
            if (rs.next())
            {
                admin = new Admin(rs.getString(1),rs.getString(2),rs.getString(3),rs.getString(4),rs.getString(5),rs.getLong(6));
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        return admin;
    }
}
