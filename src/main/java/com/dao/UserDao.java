package com.dao;

import com.dbConnection.DBConnection;
import com.entity.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDao
{
    public int registration(User user)
    {
        int k = 0;
        try
        {
            Connection con = DBConnection.getConnection();
            PreparedStatement pstm = con.prepareStatement("insert into usershopping values(?,?,?,?,?,?,?,?,?)");
            pstm.setString(1, user.getUserId());
            pstm.setString(2, user.getFullName());
            pstm.setString(3, user.getEmailId());
            pstm.setLong(4,user.getMobileNo());
            pstm.setString(5, user.getPassword());
            pstm.setString(6,user.getAddress());
            pstm.setString(7, user.getCity());
            pstm.setString(8,user.getState());
            pstm.setInt(9,user.getPincode());
            k = pstm.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return k;
    }

    public User userLogin(String emaiId,String password)
    {
        User user = null;
        try
        {
            Connection con = DBConnection.getConnection();
            PreparedStatement pstm = con.prepareStatement("select * from usershopping where emailId = ? and password = ?");
            pstm.setString(1,emaiId);
            pstm.setString(2,password);
            ResultSet rs = pstm.executeQuery();
            if (rs.next())
            {
                user =
                        new User(rs.getString(1),rs.getString(2), rs.getString(3),rs.getLong(4),rs.getString(5),
                                rs.getString(6),rs.getString(7),rs.getString(8),rs.getInt(9)
                                );
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        return user;
    }
}
