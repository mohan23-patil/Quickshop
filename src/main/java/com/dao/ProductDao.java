package com.dao;

import com.dbConnection.DBConnection;
import com.entity.Product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductDao
{
    public int insertProduct(Product product)
    {
        int k = 0;
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement pstm = con.prepareStatement("insert into quickshop values(?,?,?,?,?,?)");
            pstm.setString(1, product.getProductId());
            pstm.setString(2, product.getProductName());
            pstm.setString(3, product.getCategory());
            pstm.setDouble(4,product.getProductPrice());
            pstm.setInt(5,product.getProductQty());
            pstm.setString(6, product.getImage());
            k = pstm.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return k;
    }

    public List<Product> viewAllPoduct()
    {
        List<Product> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement pstm = con.prepareStatement("select * from quickshop");
            ResultSet rs = pstm.executeQuery();
            while (rs.next())
            {
                Product product = new Product(rs.getString(1), rs.getString(2), rs.getString(3), rs.getDouble(4), rs.getInt(5), rs.getString(6));
                list.add(product);
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        return list;
    }

    public int updateProduct(String productName,String category,double productPrice,int productQty,String image,String productId)
    {
        int k = 0;
        try
        {
            Connection con = DBConnection.getConnection();
            PreparedStatement pstm = con.prepareStatement("update quickshop set productName = ?, category = ?,  productPrice = ?, productQty = ?, image = ? where productId = ?");
            pstm.setString(1,productName);
            pstm.setString(2,category);
            pstm.setDouble(3,productPrice);
            pstm.setInt(4,productQty);
            pstm.setString(5,image);
            pstm.setString(6,productId);
            k = pstm.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return k;
    }

    public int deleteProduct(String productId)
    {
        int k = 0;
        try
        {
            Connection con = DBConnection.getConnection();
            PreparedStatement pstm = con.prepareStatement("delete from quickshop where productId = ?");
            pstm.setString(1,productId);
            k = pstm.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return k;
    }

    public Product getProductDetailsById(String productId)
    {
        Product product = null;
        try
        {
            Connection con = DBConnection.getConnection();
            PreparedStatement pstm = con.prepareStatement("select * from quickshop where productId = ?");
            pstm.setString(1,productId);
            ResultSet rs = pstm.executeQuery();
            if (rs.next())
            {
                product =
                        new Product(rs.getString(1),rs.getString(2),rs.getString(3),rs.getDouble(4),rs.getInt(5), rs.getString(6));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return product;
    }

    public List<Product> getProductByName(String productName)
    {
        List<Product> products = new ArrayList<>();
        try
        {
            Connection con = DBConnection.getConnection();
            PreparedStatement pstm = con.prepareStatement("select * from quickshop where productName like ?");
            pstm.setString(1, "%" + productName + "%");
            ResultSet rs = pstm.executeQuery();
            while (rs.next())
            {
                Product product = new Product(rs.getString(1), rs.getString(2), rs.getString(3), rs.getDouble(4), rs.getInt(5), rs.getString(6));
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
}
