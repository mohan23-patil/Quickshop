package com.dao;

import com.dbConnection.DBConnection;
import com.entity.Cart_Item;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CartDao
{
    public int addToCart(String username, String productId)
    {
        int k = 0;

        try
        {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                    "select quantity from cart_items where username=? and productId=?"
            );

            ps.setString(1, username);
            ps.setString(2, productId);

            ResultSet rs = ps.executeQuery();

            if (rs.next())
            {
                PreparedStatement ps2 = con.prepareStatement(
                        "update cart_items set quantity=quantity+1 " +
                                "where username=? and productId=?"
                );

                ps2.setString(1, username);
                ps2.setString(2, productId);

                k = ps2.executeUpdate();
            }
            else
            {
                PreparedStatement ps2 = con.prepareStatement(
                        "insert into cart_items(username, productId, quantity) " +
                                "values(?, ?, 1)"
                );

                ps2.setString(1, username);
                ps2.setString(2, productId);

                k = ps2.executeUpdate();
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

        return k;
    }

    public List<Cart_Item> viewCart(String username)
    {
        List<Cart_Item> list = new ArrayList<>();

        try
        {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                    "select q.productId, q.productName, q.productPrice, " +
                            "q.image, q.productQty, c.quantity " +
                            "from quickshop q " +
                            "join cart_items c on q.productId = c.productId " +
                            "where c.username = ?"
            );

            ps.setString(1, username);

            ResultSet rs = ps.executeQuery();

            while (rs.next())
            {
                Cart_Item item = new Cart_Item();

                item.setProductId(rs.getString("productId"));
                item.setProductName(rs.getString("productName"));
                item.setProductPrice(rs.getDouble("productPrice"));
                item.setImage(rs.getString("image"));
                item.setAvailableQty(rs.getInt("productQty"));
                item.setQuantity(rs.getInt("quantity"));

                list.add(item);
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

        return list;
    }

    public int deleteCartItem(String username, String productId)
    {
        int k = 0;

        try
        {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                    "delete from cart_items where username=? and productId=?"
            );

            ps.setString(1, username);
            ps.setString(2, productId);

            k = ps.executeUpdate();
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

        return k;
    }

    public int updateCartItem(String userName, String productId, int quantity)
    {
        int k = 0;

        if (quantity <= 0) {
            return 0;
        }

        try
        {
            Connection con = DBConnection.getConnection();

            PreparedStatement pstm = con.prepareStatement(
                    "update cart_items set quantity=? where username=? and productId=?"
            );

            pstm.setInt(1, quantity);
            pstm.setString(2, userName);
            pstm.setString(3, productId);

            k = pstm.executeUpdate();
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

        return k;
    }
}
